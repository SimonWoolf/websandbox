require 'spec_helper'

describe ProfilesController do
  before :each do
    @user1 = create(:user)
    @user2 = create(:user, email: 'another@example.com')
    @user1.profile = create(:profile)
    @user2.profile = create(:profile)
  end

  context 'not logged in' do
    it 'should not be able to edit someones page' do
      patch :update, user_id: @user1.id, profile: {html: "hah! vandalism"}
      expect(@user1.profile.html).not_to eq "hah! vandalism"
    end
  end

  context 'logged in as right user' do
    before :each do
      sign_in(@user1)
    end

    it 'should be able to edit your own page' do
      patch :update, user_id: @user1.id, profile: {html: "Legit update"}
      expect(@user1.profile.html).to eq "Legit update"
    end
  end
end
