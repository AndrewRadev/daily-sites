require 'spec_helper'

describe User do
  before :each do
    Factory(:user) # for uniqueness check
    User.where(:uid => auth[:uid]).destroy_all
  end

  it { should validate_presence_of(:uid) }
  it { should validate_presence_of(:provider) }
  it { should validate_presence_of(:name) }

  it { should validate_uniqueness_of(:uid) }

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

    user.uid.should eq auth[:uid]
    user.provider.should eq auth[:provider]
    user.name.should eq auth[:user_info][:name]
  end

  it "can be found from omniauth data" do
    Factory(:user, :uid => auth[:uid], :provider => auth[:provider])
    user = User.find_from_omniauth(auth)

    user.should be_present
  end
end
