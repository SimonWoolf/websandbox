class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.belongs_to :user1, class_name: 'User', index: true
      t.belongs_to :user2, class_name: 'User', index: true

      t.timestamps
    end
  end
end
