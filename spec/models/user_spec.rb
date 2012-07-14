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

  describe "(remember me)" do
    it "can be saved and loaded using a cookie" do
      user = Factory(:user)

      user.remember_token.should be_present
      user.serialize_into_cookie.should eq [user.id, user.remember_token]

      loaded_user = User.serialize_from_cookie([user.id, user.remember_token])
      loaded_user.should eq user
    end

    it "is regenerated after two weeks" do
      user  = Factory(:user)
      token = user.remember_token

      Timecop.freeze((2.weeks - 1.day).from_now) { user.remember_token.should eq token }
      Timecop.freeze((2.weeks + 1.day).from_now) { user.remember_token.should_not eq token }
    end
  end
end
