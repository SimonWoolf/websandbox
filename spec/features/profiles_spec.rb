require 'spec_helper'

describe 'Viewing profiles' do
  it 'should show the profile for each user at the right url' do
    @user = create(:user)
    @user.profile = create(:profile)

    visit "/users/#{@user.id}/profile"
    expect(page).to have_content "factorygirl"
  end
end

describe 'Editing profiles' do
  before :each do
    @user1 = create(:user)
    @user2 = create(:user, email: 'another@example.com')
    @user1.profile = create(:profile)
    @user2.profile = create(:profile)
  end

  context 'not logged in' do
    it 'should not be able to edit someones page' do
      page.driver.put user_profile_path(@user1), profile: {html: "hah! vandalism"}
      visit "/users/#{@user1.id}/profile"
      expect(page).not_to have_content "hah! vandalism"
    end
  end

  context 'logged in as right user' do
    before :each do
      login_as(@user1)
    end

    it 'should be able to edit your own page' do
      page.driver.put user_profile_path(@user1), profile: {html: "legit update"}
      visit "/users/#{@user1.id}/profile"
      expect(page).to have_content "legit update"
    end

    it 'should not be able to edit someone elses page' do
      page.driver.put user_profile_path(@user2), profile: {html: "vandalism"}
      visit "/users/#{@user2.id}/profile"
      expect(page).not_to have_content "vandalism"
    end
  end

end
