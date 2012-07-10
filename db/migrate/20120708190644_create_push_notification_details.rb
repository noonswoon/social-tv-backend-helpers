class CreatePushNotificationDetails < ActiveRecord::Migration
  def self.up
    create_table :push_notification_details do |t|
    	t.string :userid
    	t.string :username
    	t.string :pn_device_token
    	t.integer :notify_when_comment, :default=>1
    	t.integer :notify_when_friend_checkin, :default=>1
    	t.timestamps
    end
  end

  def self.down
  	drop_table :push_notification_details
  end
end
