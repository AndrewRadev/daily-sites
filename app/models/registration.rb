class Registration < ActiveRecord::Base
  belongs_to :user

  validates :uid,      presence: true
  validates :provider, presence: true
  validates :user,     presence: true

  validates :uid, uniqueness: { scope: :provider }

  class << self
    def already_created?(auth)
      auth = auth.deep_symbolize_keys

      find_by_uid_and_provider(auth[:uid], auth[:provider]).present?
    end
  end
end
