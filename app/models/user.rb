class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile

  has_many :masterships, class_name: 'Friendship', foreign_key: :master_id
  has_many :slaveships, class_name: 'Friendship', foreign_key: :slave_id
  # foreign_key is what this user instance is. :source is what the other user is.
  has_many :masters, through: :slaveships, source: :master
  has_many :slaves, through: :masterships, source: :slave

  def friends
    masters + slaves
  end

  def add_friend(newfriend)
    slaves << newfriend
  end

  def remove_friend(oldfriend)
    Friendship.between(self, oldfriend).destroy # :'(
  end

end
