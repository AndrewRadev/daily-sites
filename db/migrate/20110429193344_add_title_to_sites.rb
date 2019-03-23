class AddTitleToSites < ActiveRecord::Migration[4.2]
  def self.up
    add_column :sites, :title, :string
  end

  def self.down
    remove_column :sites, :title
  end
end
