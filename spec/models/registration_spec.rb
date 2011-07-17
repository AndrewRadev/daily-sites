require 'spec_helper'

describe Registration do
  it { should belong_to(:user) }

  it { should validate_presence_of(:uid) }
  it { should validate_presence_of(:provider) }

  it "disallows duplicates" do
    Factory(:registration, :uid => '123', :provider => 'twitter')

    Factory.build(:registration, :uid => '123', :provider => 'twitter').should_not be_valid
    Factory.build(:registration, :uid => '234', :provider => 'twitter').should be_valid
    Factory.build(:registration, :uid => '123', :provider => 'facebook').should be_valid
  end

  it "lets us check if the registration data is already there" do
    Factory(:registration, :uid => '123', :provider => 'twitter')
    Registration.should be_already_created(:uid => '123', :provider => 'twitter')
    Registration.should_not be_already_created(:uid => '234', :provider => 'twitter')
    Registration.should_not be_already_created(:uid => '123', :provider => 'facebook')
  end
end
