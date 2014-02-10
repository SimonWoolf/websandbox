require 'spec_helper'

describe 'Guest', js: true, slow: true do
  context 'not signed in' do
    specify 'click save should let you create account, which preserves your changes' do
      visit '/'
      find('#edit_button').click
      find('#example_element').click
      fill_in('edit_field_html', with: '<p id="example_element">should be saved</p>')
      find('#grid-background').click
      # make sure it's added it to the page
      expect(page.find('.profile_content p')).to have_content 'should be saved'
      find('#save').click
      # wait for ajax response
      click_link 'Sign up'
      fill_in 'Name', with: 'Testname'
      fill_in 'Email', with: 'Testname@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Sign up'
      expect(page).to have_content 'should be saved'
    end
  end
end
