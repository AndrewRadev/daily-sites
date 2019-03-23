class RemoveUserRegistrationData < ActiveRecord::Migration[4.2]
  def self.up
    remove_column :users, :uid
    remove_column :users, :provider
  end

  def self.down
    add_column :users, :provider, :string
    add_column :users, :uid,      :string
  end
end
