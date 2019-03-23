require 'rails_helper'

RSpec.describe User do
  before :each do
    create(:user) # for uniqueness check
    Registration.where(uid: auth[:uid]).destroy_all
  end

  let(:auth) do
    {
      uid: '123',
      provider: 'twitter',
      user_info: { name: 'John Doe' },
    }
  end

  it "can be created from omniauth data" do
    user = User.create_from_omniauth(auth)
    registration = user.registrations.first
    expect(registration).to be_present

    expect(user.name).to eq auth[:user_info][:name]
    expect(registration.uid).to eq auth[:uid]
    expect(registration.provider).to eq auth[:provider]
  end

  it "can be found from omniauth data" do
    create(:registration, :uid => auth[:uid], :provider => auth[:provider])
    user = User.find_from_omniauth(auth)

    expect(user).to be_present
  end

  it "can create additional registrations from omniauth data" do
    user = create(:user)

    expect {
      user.create_registration_from_omniauth(auth.merge(:uid => '234'))
      user.reload
    }.to change(user.registrations, :count).by +1
  end

  describe "(remember me)" do
    it "can be saved and loaded using a cookie" do
      user = create(:user)

      expect(user.remember_token).to be_present
      expect(user.serialize_into_cookie).to eq [user.id, user.remember_token]

      loaded_user = User.serialize_from_cookie([user.id, user.remember_token])
      expect(loaded_user).to eq user
    end

    it "is regenerated after two weeks" do
      user  = create(:user)
      token = user.remember_token

      Timecop.freeze((2.weeks - 1.day).from_now) { expect(user.remember_token).to eq token }
      Timecop.freeze((2.weeks + 1.day).from_now) { expect(user.remember_token).not_to eq token }
    end
  end
end
