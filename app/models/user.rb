class User < ActiveRecord::Base
  class << self
    def find_or_create_from_omniauth(auth)
      find_from_omniauth(auth) || create_from_omniauth(auth)
    end

    def create_from_omniauth(auth)
      auth = auth.deep_symbolize_keys

      create! do |u|
        u.uid      = auth[:uid]
        u.provider = auth[:provider]
        u.name     = auth[:user_info][:name]
      end
    end

    def find_from_omniauth(auth)
      auth = auth.deep_symbolize_keys

      find_by_uid_and_provider(auth[:uid], auth[:provider])
    end
  end
end
