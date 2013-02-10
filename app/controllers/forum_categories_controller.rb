class ForumCategoriesController < ApplicationController
  before_filter { |b| b.require_power 5 }
  before_filter :set_page_id

  # GET /forum_categories
  # GET /forum_categories.json
  def index
    @forum_categories = ForumCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @forum_categories }
    end
  end

  # GET /forum_categories/1
  # GET /forum_categories/1.json
  def show
    @forum_category = ForumCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @forum_category }
    end
  end

  # GET /forum_categories/new
  # GET /forum_categories/new.json
  def new
    @forum_category = ForumCategory.new
    @position = next_position

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @forum_category }
    end
  end

  # GET /forum_categories/1/edit
  def edit
    @forum_category = ForumCategory.find(params[:id])
  end

  # POST /forum_categories
  # POST /forum_categories.json
  def create
    @forum_category = ForumCategory.new(params[:forum_category])

    respond_to do |format|
      if @forum_category.save
        if @forum_category.position.blank?
          @forum_category.position = next_position
          @forum_category.save
        end
        format.html { redirect_to forums_path, notice: 'Forum category was successfully created.' }
        format.json { render json: @forum_category, status: :created, location: @forum_category }
      else
        format.html { render action: "new" }
        format.json { render json: @forum_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /forum_categories/1
  # PUT /forum_categories/1.json
  def update
    @forum_category = ForumCategory.find(params[:id])

    respond_to do |format|
      if @forum_category.update_attributes(params[:forum_category])
        if @forum_category.position.blank?
          @forum_category.position = next_position
          @forum_category.save
        end
        format.html { redirect_to forums_path, notice: 'Forum category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @forum_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forum_categories/1
  # DELETE /forum_categories/1.json
  def destroy
    @forum_category = ForumCategory.find(params[:id])
    @forum_category.destroy

    respond_to do |format|
      format.html { redirect_to forums_path }
      format.json { head :no_content }
    end
  end

  protected

  def next_position
    last_forum = ForumCategory.last
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
