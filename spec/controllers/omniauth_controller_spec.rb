require 'spec_helper'

describe OmniauthController do
  describe "callback" do
    let(:user) { create(:user) }

    before :each do
      User.stub(:find_or_create_from_omniauth => user)
    end

    def make_request(opts = {})
      post :callback, {}.merge(opts)
    end

    context "no user logged in" do
      it "redirects to the root" do
        make_request
        response.should redirect_to root_path
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

    context "user logged in" do
      before :each do
        log_in_as create(:user)
        current_user.stub(:create_registration_from_omniauth => true)
        Registration.stub(:already_created? => false)
      end

      it "redirects to the current user's profile" do
        make_request
        response.should redirect_to profile_path
      end

      it "adds a new registration to the user" do
        current_user.should_receive(:create_registration_from_omniauth).and_return(true)
        make_request
        flash[:notice].should be_present
      end

      it "disallows adding an existing registration" do
        Registration.should_receive(:already_created?).and_return(true)
        make_request
        flash[:error].should be_present
      end
    end
  end
end
