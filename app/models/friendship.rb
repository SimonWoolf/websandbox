class Friendship < ActiveRecord::Base
  belongs_to :master, class_name: 'User'
  belongs_to :slave, class_name: 'User'

  def self.between(one, another)
    (Friendship.where(master: one, slave:another) + Friendship.where(master: another, slave: one)).first
  end
end
