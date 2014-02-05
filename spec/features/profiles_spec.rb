require 'spec_helper'

describe 'Viewing posts' do
  it 'should show the profile for each user at the right url' do
    @user = create(:user)
    @user.profile = create(:profile)

    visit "/users/#{@user.id}/profile"
    expect(page).to have_content "factorygirl"
  end
end
