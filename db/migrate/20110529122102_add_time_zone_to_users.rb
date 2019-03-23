class AddTimeZoneToUsers < ActiveRecord::Migration[4.2]
  def self.up
    add_column :users, :time_zone, :string
  end

  def self.down
    remove_column :users, :time_zone
  end
end
