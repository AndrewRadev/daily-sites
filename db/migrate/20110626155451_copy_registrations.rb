class CopyRegistrations < ActiveRecord::Migration[4.2]
  class User < ActiveRecord::Base
  end

  def self.up
    User.all.each do |u|
      u.registrations.create! do |r|
        r.uid      = u.uid
        r.provider = u.provider
      end
    end
  end

  def self.down
    Registration.all.each do |r|
      user = r.user

      user.uid      = r.uid
      user.provider = r.provider
      user.save!
    end
  end
end
