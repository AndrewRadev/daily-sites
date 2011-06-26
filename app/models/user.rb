class User < ActiveRecord::Base
  has_many :sites
  has_many :registrations

  validates :name, :presence => true

  class << self
    def find_or_create_from_omniauth(auth)
      find_from_omniauth(auth) || create_from_omniauth(auth)
    end

    def create_from_omniauth(auth)
      auth = auth.deep_symbolize_keys

      create! do |u|
        u.name = auth[:user_info][:name]
        u.registrations.build do |r|
          r.uid      = auth[:uid]
          r.provider = auth[:provider]
        end
      end
    end

    def find_from_omniauth(auth)
      auth = auth.deep_symbolize_keys

      registration = Registration.find_by_uid_and_provider(auth[:uid], auth[:provider])
      registration.try(:user)
    end
  end
end
