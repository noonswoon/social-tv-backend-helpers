class PushNotificationDetail < ActiveRecord::Base
  attr_accessible :notify_when_comment, :notify_when_friend_checkin, :pn_device_token, :userid, :username
  validates :userid, :presence => true
  validates :username, :presence => true
  validates :pn_device_token #, :presence => true
end
