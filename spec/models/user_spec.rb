require 'spec_helper'

describe User do
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
    User.create_sample(:uid => auth[:uid], :provider => auth[:provider])
    user = User.find_from_omniauth(auth)

    user.should be_present
  end
end
