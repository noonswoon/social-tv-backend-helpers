require 'test_helper'

class PushNotificationDetailsControllerTest < ActionController::TestCase
  setup do
    @push_notification_detail = push_notification_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:push_notification_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create push_notification_detail" do
    assert_difference('PushNotificationDetail.count') do
      post :create, push_notification_detail: { notify_when_comment: @push_notification_detail.notify_when_comment, notify_when_friend_checkin: @push_notification_detail.notify_when_friend_checkin, pn_device_token: @push_notification_detail.pn_device_token, userid: @push_notification_detail.userid, username: @push_notification_detail.username }
    end

    assert_redirected_to push_notification_detail_path(assigns(:push_notification_detail))
  end

  test "should show push_notification_detail" do
    get :show, id: @push_notification_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @push_notification_detail
    assert_response :success
  end

  test "should update push_notification_detail" do
    put :update, id: @push_notification_detail, push_notification_detail: { notify_when_comment: @push_notification_detail.notify_when_comment, notify_when_friend_checkin: @push_notification_detail.notify_when_friend_checkin, pn_device_token: @push_notification_detail.pn_device_token, userid: @push_notification_detail.userid, username: @push_notification_detail.username }
    assert_redirected_to push_notification_detail_path(assigns(:push_notification_detail))
  end

  test "should destroy push_notification_detail" do
    assert_difference('PushNotificationDetail.count', -1) do
      delete :destroy, id: @push_notification_detail
    end

    assert_redirected_to push_notification_details_path
  end
end
