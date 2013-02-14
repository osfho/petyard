class ProjectsController < ApplicationController
  before_filter(:only => [:new, :create, :edit, :update, :join]) { |b| b.require_power 1 }
  before_filter(:only => [:destroy]) { |b| b.require_power 4 }
  before_filter :set_page_id

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.visible

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.includes(:project_memberships).find_by_permalink(params[:id])

    @founderships = @project.project_memberships.foundership
    @adminships = @project.project_memberships.adminship
    @memberships = @project.project_memberships.membership

    if @project.visible == false && !@project.users.include?(current_user)
      redirect_to projects_url
      return false
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find_by_permalink(params[:id])
    unless (current_user.project_role(@project) == "founder" || current_user.project_role(@project) == "admin") || current_user.has_power(4)
      flash[:notice] = "You do not have permission to edit this project. Please contact an administrator if you feel that this is an error.<br /><br /><a href='#{project_path(@project)}'>Back to project</a>"
      redirect_to notify_path
    end
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])
    @project.permalink = create_permalink(params[:project][:title])
    @project_membership = @project.project_memberships.build(:user_id => current_user.id, :role => "founder")

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find_by_permalink(params[:id])

    unless (current_user.project_role(@project) == "founder" || current_user.project_role(@project) == "admin") || current_user.has_power(4)
      flash[:notice] = "You do not have permission to edit this project. Please contact an administrator if you feel that this is an error.<br /><br /><a href='#{project_path(@project)}'>Back to project</a>"
      redirect_to notify_path
    end

    @project.permalink = create_permalink(params[:project][:title]) if params[:update_permalink]

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find_by_permalink(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  def join
    @project = Project.find_by_permalink(params[:id])

    if @project.users.include?(current_user)
      redirect_to @project
    else
      @project_membership = @project.project_memberships.build(:project_id => @project.id, :user_id => current_user.id)
    end

    respond_to do |format|
      if @project_membership.save
        format.html { redirect_to @project, notice: 'User added.' }
        format.json { render json: @project, status: :created, location: @project }
      end
    end
  end

  protected

  def set_page_id
    @page_id = 'projects'
  end
end
