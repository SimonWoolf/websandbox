require 'spec_helper'

describe 'Users' do
  it 'should list all users' do
    @user1 = create(:user)
    @user1.profile = create(:profile)
    @user2 = create(:user, email: 'anotheruser@example.com')
    @user2.profile = create(:profile)

    visit '/users'
    expect(page).to have_content 'factorygirl@example.com'
    expect(page).to have_content 'anotheruser@example.com'
  end
end
