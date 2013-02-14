class ProjectMembershipsController < ApplicationController

  # GET /project_memberships/new
  # GET /project_memberships/new.json
  def new
    @project = Project.find_by_permalink(params[:project_id])
    @project_membership = @project.project_memberships.build
    all_users = User.all
    @users = all_users - @project.users

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project_membership }
    end
  end

  # POST /project_memberships
  # POST /project_memberships.json
  def create
    @project = Project.find_by_permalink(params[:project_id])
    @project_membership = @project.project_memberships.build(params[:project_membership])

    respond_to do |format|
      if @project_membership.save
        format.html { redirect_to @project, notice: 'Project membership was successfully created.' }
        format.json { render json: @project, status: :created, location: @project_membership }
      else
        format.html { render action: "new" }
        format.json { render json: @project_membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_memberships/1
  # DELETE /project_memberships/1.json
  def destroy
    @project = Project.find_by_permalink(params[:project_id])
    @project_membership = ProjectMembership.find(params[:id])
    @project_membership.destroy

    respond_to do |format|
      format.html { redirect_to @project }
      format.json { head :no_content }
    end
  end
end
