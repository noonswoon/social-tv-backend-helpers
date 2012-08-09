require 'test_helper'

class ChatroomManagersControllerTest < ActionController::TestCase
  setup do
    @chatroom_manager = chatroom_managers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:chatroom_managers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create chatroom_manager" do
    assert_difference('ChatroomManager.count') do
      post :create, chatroom_manager: { chatroom_id: @chatroom_manager.chatroom_id, number_users: @chatroom_manager.number_users }
    end

    assert_redirected_to chatroom_manager_path(assigns(:chatroom_manager))
  end

  test "should show chatroom_manager" do
    get :show, id: @chatroom_manager
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @chatroom_manager
    assert_response :success
  end

  test "should update chatroom_manager" do
    put :update, id: @chatroom_manager, chatroom_manager: { chatroom_id: @chatroom_manager.chatroom_id, number_users: @chatroom_manager.number_users }
    assert_redirected_to chatroom_manager_path(assigns(:chatroom_manager))
  end

  test "should destroy chatroom_manager" do
    assert_difference('ChatroomManager.count', -1) do
      delete :destroy, id: @chatroom_manager
    end

    assert_redirected_to chatroom_managers_path
  end
end
