class TopicsController < ApplicationController
  before_filter(:except => :show) { |b| b.require_power 1 }
  before_filter :set_page_id, :find_players_online

  # GET /topics
  # GET /topics.json
  def index
    @forum = Forum.find_by_permalink(params[:forum_id])
    
    redirect_to @forum
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @forum = Forum.includes(:topics).find_by_permalink(params[:forum_id])
    @topic = @forum.topics.includes(:posts).find_by_permalink(params[:id])
    @posts = @topic.posts.order("id asc")

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.json
  def new
    @forum = Forum.find_by_permalink(params[:forum_id])
    @topic = @forum.topics.build
    @post = @topic.posts.build

    if @forum.accessibility == "staff-only"
      require_power(2)
    end

    if @forum.accessibility == "read-only" || @forum.accessibility == "reply-only"
      require_power(4)
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @forum = Forum.find_by_permalink(params[:forum_id])
    @topic = @forum.topics.find_by_permalink(params[:id])
    @post = @topic.posts.first

    unless (@topic.editable? && current_user == @topic.user) || current_user.has_power(3)
      flash[:topic_error] = "You cannot edit a topic after 30 seconds."
      redirect_to forum_topic_path(@forum, @topic)
    end
  end

  # POST /topics
  # POST /topics.json
  def create
    @forum = Forum.find_by_permalink(params[:forum_id])
    @topic = @forum.topics.build(params[:topic])
    @post = Post.new(params[:post])

    @topic.user = current_user
    @topic.latest_post_id = @post.id
    @post.user = current_user
    @post.topic = @topic
    @post.title = @topic.title
    @topic.permalink = create_permalink(params[:topic][:title])

    respond_to do |format|
      if @post.save && @topic.save
        @topic.latest_post_id = @post.id
        @topic.save
        format.html { redirect_to forum_topic_path(@forum, @topic), notice: 'Topic was successfully created.' }
        format.json { render json: @topic, status: :created, location: @topic }
      else
        format.html { render action: "new" }
        format.json { render json: [@topic.errors, @post.errors], status: :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.json
  def update
    @forum = Forum.find_by_permalink(params[:forum_id])
    @topic = Topic.find_by_permalink(params[:id])
    @post = @topic.posts.order("id asc").first

    @topic.permalink = create_permalink(params[:topic][:title]) if params[:update_permalink]

    respond_to do |format|
      if @topic.update_attributes(params[:topic]) && @post.update_attributes(params[:post])
        @post.title = @topic.title
        @post.save
        format.html { redirect_to forum_topic_path(@forum, @topic), notice: 'Topic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @forum = Forum.find_by_permalink(params[:forum_id])
    @topic = @forum.topics.find_by_permalink(params[:id])

    unless (@topic.editable? && current_user == @topic.user) || current_user.has_power(4)
      flash[:topic] = "You cannot delete a topic after 30 seconds."
      redirect_to [@forum, @topic]
      return false
    end

    @topic.destroy

    respond_to do |format|
      format.html { redirect_to @forum }
      format.json { head :no_content }
    end
  end

  protected

  def set_page_id
    @page_id = 'forums'
  end

  def find_players_online
    @players_online = get_players_online
  end

end
