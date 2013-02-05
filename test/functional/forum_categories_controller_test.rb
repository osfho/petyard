require 'test_helper'

class ForumCategoriesControllerTest < ActionController::TestCase
  setup do
    @forum_category = forum_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:forum_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create forum_category" do
    assert_difference('ForumCategory.count') do
      post :create, forum_category: { position: @forum_category.position, title: @forum_category.title }
    end

    assert_redirected_to forum_category_path(assigns(:forum_category))
  end

  test "should show forum_category" do
    get :show, id: @forum_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @forum_category
    assert_response :success
  end

  test "should update forum_category" do
    put :update, id: @forum_category, forum_category: { position: @forum_category.position, title: @forum_category.title }
    assert_redirected_to forum_category_path(assigns(:forum_category))
  end

  test "should destroy forum_category" do
    assert_difference('ForumCategory.count', -1) do
      delete :destroy, id: @forum_category
    end

    assert_redirected_to forum_categories_path
  end
end
