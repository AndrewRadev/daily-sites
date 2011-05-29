require 'spec_helper'

describe PagesController do
  describe "about" do
    it "renders about template" do
      get :about
      response.should render_template(:about)
    end
  end
end
