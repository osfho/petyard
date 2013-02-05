require 'test_helper'

class ModMessagesControllerTest < ActionController::TestCase
  setup do
    @mod_message = mod_messages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mod_messages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mod_message" do
    assert_difference('ModMessage.count') do
      post :create, mod_message: { body: @mod_message.body, post_id: @mod_message.post_id, user_id: @mod_message.user_id }
    end

    assert_redirected_to mod_message_path(assigns(:mod_message))
  end

  test "should show mod_message" do
    get :show, id: @mod_message
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mod_message
    assert_response :success
  end

  test "should update mod_message" do
    put :update, id: @mod_message, mod_message: { body: @mod_message.body, post_id: @mod_message.post_id, user_id: @mod_message.user_id }
    assert_redirected_to mod_message_path(assigns(:mod_message))
  end

  test "should destroy mod_message" do
    assert_difference('ModMessage.count', -1) do
      delete :destroy, id: @mod_message
    end

    assert_redirected_to mod_messages_path
  end
end
