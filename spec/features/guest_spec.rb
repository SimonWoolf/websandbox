require 'spec_helper'

describe 'Guest', js: true, slow: true do
  context 'not signed in' do
    specify 'click save should let you create account, which preserves your changes' do
      visit '/'
      find('#edit_button').click
      find('#example_element').click
      fill_in('#edit_field_html', with: '<p id="example_element">should be saved</p>')
      find('#save').click
    end
  end
end
