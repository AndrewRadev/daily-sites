class Registration < ActiveRecord::Base
  belongs_to :user

  validates :uid,      :presence => true
  validates :provider, :presence => true
  validates :user,     :presence => true
end
