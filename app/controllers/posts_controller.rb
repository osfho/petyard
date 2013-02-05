class PostsController < ApplicationController
  before_filter { |b| b.require_power 1 }
  before_filter :set_page_id

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @forum = Forum.find_by_permalink(params[:forum_id])

    if @forum.accessibility == "staff-only"
      require_power(2)
      return false
    end

    if @forum.accessibility == "read-only"
      require_power(3)
      return false
    end

    @topic = Topic.find_by_permalink(params[:topic_id])
    @post = @topic.posts.build
    
    if @topic.locked?
      require_power(3)
      return false
    end

    if params[:quote]
      @quote = Post.find(params[:quote]).quote
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @forum = Forum.find_by_permalink(params[:forum_id])
    @topic = @forum.topics.find_by_permalink(params[:topic_id])
    @post = @topic.posts.find(params[:id])

    unless (@post.editable? && current_user == @post.user) || current_user.has_power(3)
      flash[:topic_error] = "You cannot edit a post after 30 seconds."
      redirect_to [@forum, @topic]
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @forum = Forum.find_by_permalink(params[:forum_id])
    @topic = Topic.find_by_permalink(params[:topic_id])
    @post = @topic.posts.build(params[:post])

    @post.user = current_user
    @post.title = "Re: " + @topic.title

    respond_to do |format|
      if @post.save
        @topic.latest_post_id = @post.id
        @topic.save
        format.html { redirect_to forum_topic_path(@forum, @topic, :anchor => @post.id), notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @forum = Forum.find_by_permalink(params[:forum_id])
    @topic = Topic.find_by_permalink(params[:topic_id])
    @post = @topic.posts.find(params[:id])

    @topic.latest_post_id = @post.id

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to forum_topic_path(@forum, @topic, :anchor => @post.id), notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @forum = Forum.find_by_permalink(params[:forum_id])
    @topic = Topic.find_by_permalink(params[:topic_id])
    @post = Post.find(params[:id])

    unless (@post.editable? && current_user == @post.user) || current_user.has_power(3)
      flash[:topic_error] = "You cannot edit a post after 30 seconds."
      redirect_to [@forum, @topic]
    else
      @post.destroy

      respond_to do |format|
        format.html { redirect_to [@forum, @topic] }
        format.json { head :no_content }
      end
    end
  end

  protected

  def set_page_id
    @page_id = 'forums'
  end

end
