require 'spec_helper'
require 'paper_trail/frameworks/rspec'

describe 'Versioning', versioning: true do
  before :each do
    user = create(:user)
    user.profile = create(:profile)
    login_as(user)
  end

  it 'should revert to a previous version' do
    visit '/'
    expect(page).to have_content "factorygirl"

    user.profile.update(html: "<p>updated</p>") #TODO: replace with capybara interaction once nicky's changes merged
    visit '/'
    expect(page).to have_content "updated"

    #raise user.profile.versions.inspect

    click_link 'Previous'
    expect(page).to have_content "factorygirl"
  end

  specify 'version history' do
    visit '/'
    user.profile.update(html: "<p>updated</p>") #TODO: replace with capybara interaction once nicky's changes merged
    user.profile.update(html: "<p>again</p>") #TODO: replace with capybara interaction once nicky's changes merged
    click_link 'Version history'
    click_link 'Revert to this version'
    expect(page).to have_content "factorygirl"
  end
end
