require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project" do
    assert_difference('Project.count') do
      post :create, project: { creator_id: @project.creator_id, description: @project.description, feature_image: @project.feature_image, invite_only: @project.invite_only, permalink: @project.permalink, status: @project.status, title: @project.title, visible: @project.visible, x_coordinate: @project.x_coordinate, y_coordinate: @project.y_coordinate, z_coordinate: @project.z_coordinate }
    end

    assert_redirected_to project_path(assigns(:project))
  end

  test "should show project" do
    get :show, id: @project
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project
    assert_response :success
  end

  test "should update project" do
    put :update, id: @project, project: { creator_id: @project.creator_id, description: @project.description, feature_image: @project.feature_image, invite_only: @project.invite_only, permalink: @project.permalink, status: @project.status, title: @project.title, visible: @project.visible, x_coordinate: @project.x_coordinate, y_coordinate: @project.y_coordinate, z_coordinate: @project.z_coordinate }
    assert_redirected_to project_path(assigns(:project))
  end

  test "should destroy project" do
    assert_difference('Project.count', -1) do
      delete :destroy, id: @project
    end

    assert_redirected_to projects_path
  end
end
