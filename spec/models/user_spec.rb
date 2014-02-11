require 'spec_helper'

describe User do
  before do
    @user1 = create(:user)
    @user2 = create(:user, email: 'anotheruser@example.com')
  end

  describe '#add_friend' do
    it 'should add Friendships objects as appropriate' do
      @user1.add_friend(@user2)
      expect(@user1.friends).to include(@user2)
      expect(@user2.friends).to include(@user1)
    end
  end

  describe '#remove_friends' do
    it 'should remove Friendships objects as appropriate' do
      @user1.add_friend(@user2)
      @user1.remove_friend(@user2)
      expect(@user1.friends(true)).not_to include(@user2)
      expect(@user2.friends(true)).not_to include(@user1)
    end
  end
end
