require 'spec_helper'

describe OmniauthController do
  describe "callback" do
    let(:user) { Factory(:user) }

    before :each do
      User.stub(:find_or_create_from_omniauth => user)
    end

    def make_request(opts = {})
      post :callback, {}.merge(opts)
    end

    it "redirects to the root" do
      make_request
      response.should redirect_to root_url
    end

    it "finds or creates a user from the omniauth data" do
      User.should_receive(:find_or_create_from_omniauth).and_return(user)
      make_request
    end

    it "saves the user in the session" do
      make_request
      session[:user_id].should eq user.id
    end
  end
end