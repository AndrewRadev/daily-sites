class CreateRegistrations < ActiveRecord::Migration[4.2]
  def self.up
    create_table :registrations do |t|
      t.string :uid
      t.string :provider
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :registrations
  end
end
