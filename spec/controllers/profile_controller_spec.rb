require 'spec_helper'

describe ProfilesController do
  before :each do
    log_in_as Factory(:user)
  end

  describe "show" do
    def make_request(opts = {})
      get :show, {}.merge(opts)
    end

    it "renders the show template" do
      make_request
      response.should render_template :show
    end
  end

  describe "edit" do
    def make_request(opts = {})
      post :edit, {}.merge(opts)
    end

    it "renders the edit template" do
      make_request
      response.should render_template :edit
    end
  end

  describe "update" do
    let(:attrs) { current_user.attributes }

    def make_request(opts = {})
      put :update, { :user => attrs }.merge(opts)
    end

    it "renders the edit template when user is invalid" do
      current_user.stub(:update_attributes => false)
      make_request
      response.should render_template(:edit)
    end

    it "redirects to the show page when it's valid" do
      make_request
      response.should redirect_to assigns(:model)
    end
  end

  describe "destroy" do
    def make_request(opts = {})
      delete :destroy, {}.merge(opts)
    end

    it "destroys the current user's account" do
      make_request
      User.exists?(current_user.id).should be_false
    end

    it "redirects to the about page" do
      make_request
      response.should redirect_to about_page_path
    end
  end
end
