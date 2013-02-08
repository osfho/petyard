class ForumsController < ApplicationController
  before_filter(:except => [:index, :show]) { |b| b.require_power 4 }
  before_filter :set_page_id

  # GET /forums
  # GET /forums.json
  def index
    @forum_categories = ForumCategory.includes(:forums).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @forums }
    end
  end

  # GET /forums/1
  # GET /forums/1.json
  def show
    @forum = Forum.includes(:topics).find_by_permalink(params[:id])
    @topics = @forum.topics.notstickied
    @stickies = @forum.topics.stickied

    if @forum.accessibility == "staff-only"
      require_power(2)
      return false
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @forum }
    end
  end

  # GET /forums/new
  # GET /forums/new.json
  def new
    @forum_categories = ForumCategory.all
    @forum = Forum.new
    @position = next_position

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @forum }
    end
  end

  # GET /forums/1/edit
  def edit
    @forum_categories = ForumCategory.all
    @forum = Forum.find_by_permalink(params[:id])
  end

  # POST /forums
  # POST /forums.json
  def create
    @forum = Forum.new(params[:forum])

    @forum.permalink = create_permalink(@forum.title)

    respond_to do |format|
      if @forum.save
        if @forum.position.blank?
          @forum.position = next_position
          @forum.save
        end
        format.html { redirect_to forums_path, notice: 'Forum was successfully created.' }
        format.json { render json: @forum, status: :created, location: @forum }
      else
        format.html { render action: "new" }
        format.json { render json: @forum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /forums/1
  # PUT /forums/1.json
  def update
    @forum = Forum.find_by_permalink(params[:id])

    @forum.permalink = create_permalink(params[:forum][:title])

    respond_to do |format|
      if @forum.update_attributes(params[:forum])
        if @forum.position.blank?
          @forum.position = next_position
          @forum.save
        end
        format.html { redirect_to forums_path, notice: 'Forum was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @forum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forums/1
  # DELETE /forums/1.json
  def destroy
    @forum = Forum.find_by_permalink(params[:id])
    @forum.destroy

    respond_to do |format|
      format.html { redirect_to forums_url }
      format.json { head :no_content }
    end
  end

  protected

  def next_position
    last_forum = Forum.last
    if last_forum
      return last_forum.position + 1
    else
      return 0
    end
  end

  def set_page_id
    @page_id = 'forums'
  end

end
