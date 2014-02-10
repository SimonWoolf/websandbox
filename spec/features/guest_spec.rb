require 'spec_helper'

describe 'Guest', js: true, slow: true do
  context 'not signed in' do
    specify 'click save should let you create account, which preserves your changes' do
      visit '/'
      find('#edit_button').click
      #find('#example_element').click
      #page.find('#example_element').trigger(:click)
      #page.find('.profile_content').trigger(:click)
      page.execute_script("$('.profile_content').trigger('click')")
      fill_in('#edit_field_html', with: '<p id="example_element">should be saved</p>')
      find('#save').click
    end
  end
end