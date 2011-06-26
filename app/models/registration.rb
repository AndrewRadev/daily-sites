class Registration < ActiveRecord::Base
  belongs_to :user

  validates :uid,      :presence => true
  validates :provider, :presence => true
end
