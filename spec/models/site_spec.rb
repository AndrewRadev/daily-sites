require 'spec_helper'

describe Site do
  it "keeps the days it's active in an array" do
    site = Site.sample

    site.days << Site::Wednesday
    site.days << Site::Monday
    site.days << Site::Friday

    site.save!

    site.reload

    site.days.should eq [Site::Monday, Site::Wednesday, Site::Friday].to_set
  end
end
