class AddTitleToSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :title, :string
  end

  def self.down
    remove_column :sites, :title
  end
end
