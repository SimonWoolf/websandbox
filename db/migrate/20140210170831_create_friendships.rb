class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.belongs_to :master, class_name: 'User', index: true
      t.belongs_to :slave, class_name: 'User', index: true

      t.timestamps
    end
  end
end
