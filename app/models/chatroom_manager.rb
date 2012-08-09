class ChatroomManager < ActiveRecord::Base
  attr_accessible :chatroom_id, :number_users
end
