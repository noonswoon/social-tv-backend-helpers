class CreateChatroomManagers < ActiveRecord::Migration
  def self.up
    create_table :chatroom_managers do |t|
    	t.string :chatroom_id
    	t.integer :number_users, :default=>0
    	t.timestamps
    end
  end

  def self.down
  	drop_table :chatroom_managers
  end
end
