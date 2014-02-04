class AddHtmlToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :html, :text
  end
end
