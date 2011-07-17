require 'spec_helper'

describe User do
  before :each do
    Factory(:user) # for uniqueness check
    Registration.where(:uid => auth[:uid]).destroy_all
  end

  it { should have_many(:sites) }
  it { should have_many(:registrations) }

  it { should validate_presence_of(:name) }

  let(:auth) do
    {
      :uid       => '123',
      :provider  => 'twitter',
      :user_info => {
        :name => 'John Doe',
      },
    }
  end

  it "can be created from omniauth data" do
    user = User.create_from_omniauth(auth)
    registration = user.registrations.first
    registration.should be_present

    user.name.should eq auth[:user_info][:name]
    registration.uid.should eq auth[:uid]
    registration.provider.should eq auth[:provider]
  end

  it "can be found from omniauth data" do
    Factory(:registration, :uid => auth[:uid], :provider => auth[:provider])
    user = User.find_from_omniauth(auth)

    user.should be_present
  end

  it "can create additional registrations from omniauth data" do
    user = Factory(:user)

    expect {
      user.create_registration_from_omniauth(auth.merge(:uid => '234'))
      user.reload
    }.to change(user.registrations, :count).by +1
  end
end
