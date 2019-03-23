class CreateSites < ActiveRecord::Migration[4.2]
  def self.up
    create_table :sites do |t|
      t.string :url
      t.text :days

      t.timestamps
    end
  end

  def self.down
    drop_table :sites
  end
end
