class User < ActiveRecord::Base
  has_many :sites,         :dependent => :destroy
  has_many :registrations, :dependent => :destroy

  validates :name, :presence => true

  class << self
    def find_or_create_from_omniauth(auth)
      find_from_omniauth(auth) || create_from_omniauth(auth)
    end

    def create_from_omniauth(auth)
      auth = auth.deep_symbolize_keys

      user = create! do |u|
        u.name = auth[:user_info][:name]
      end

      Registration.create! do |r|
        r.uid      = auth[:uid]
        r.provider = auth[:provider]
        r.user     = user
      end

      user
    end

    def find_from_omniauth(auth)
      auth = auth.deep_symbolize_keys

      registration = Registration.find_by_uid_and_provider(auth[:uid], auth[:provider])
      registration.try(:user)
    end
  end
end
