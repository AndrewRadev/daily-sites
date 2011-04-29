require 'spec_helper'

describe SitesController do
  def mock_site(stubs={})
    @mock_site ||= mock_model(Site, stubs).as_null_object
  end

  describe "index" do
    it "assigns all sites as @sites" do
      Site.stub(:all) { [mock_site] }
      get :index
      assigns(:sites).should eq([mock_site])
    end
  end

  describe "show" do
    it "assigns the requested site as @site" do
      Site.stub(:find).with("37") { mock_site }
      get :show, :id => "37"
      assigns(:site).should be(mock_site)
    end
  end

  describe "new" do
    it "assigns a new site as @site" do
      Site.stub(:new) { mock_site }
      get :new
      assigns(:site).should be(mock_site)
    end
  end

  describe "edit" do
    it "assigns the requested site as @site" do
      Site.stub(:find).with("37") { mock_site }
      get :edit, :id => "37"
      assigns(:site).should be(mock_site)
    end
  end

  describe "create" do
    describe "with valid params" do
      it "assigns a newly created site as @site" do
        Site.stub(:new).with({'these' => 'params'}) { mock_site(:save => true) }
        post :create, :site => {'these' => 'params'}
        assigns(:site).should be(mock_site)
      end

      it "redirects to the created site" do
        Site.stub(:new) { mock_site(:save => true) }
        post :create, :site => {}
        response.should redirect_to(site_url(mock_site))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved site as @site" do
        Site.stub(:new).with({'these' => 'params'}) { mock_site(:save => false) }
        post :create, :site => {'these' => 'params'}
        assigns(:site).should be(mock_site)
      end

      it "re-renders the 'new' template" do
        Site.stub(:new) { mock_site(:save => false) }
        post :create, :site => {}
        response.should render_template("new")
      end
    end
  end

  describe "update" do
    describe "with valid params" do
      it "updates the requested site" do
        Site.stub(:find).with("37") { mock_site }
        mock_site.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :site => {'these' => 'params'}
      end

      it "assigns the requested site as @site" do
        Site.stub(:find) { mock_site(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:site).should be(mock_site)
      end

      it "redirects to the site" do
        Site.stub(:find) { mock_site(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(site_url(mock_site))
      end
    end

    describe "with invalid params" do
      it "assigns the site as @site" do
        Site.stub(:find) { mock_site(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:site).should be(mock_site)
      end

      it "re-renders the 'edit' template" do
        Site.stub(:find) { mock_site(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "destroy" do
    it "destroys the requested site" do
      Site.stub(:find).with("37") { mock_site }
      mock_site.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the sites list" do
      Site.stub(:find) { mock_site }
      delete :destroy, :id => "1"
      response.should redirect_to(sites_url)
    end
  end
end
