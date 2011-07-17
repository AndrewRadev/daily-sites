require 'spec_helper'

describe SessionsController do
  describe "destroy" do
    it "logs the current user out" do
      session[:user_id] = '123'
      delete :destroy
      session[:user_id].should be_nil
    end

    it "redirects to the about page" do
      delete :destroy
      response.should redirect_to login_page_path
    end
  end
end
