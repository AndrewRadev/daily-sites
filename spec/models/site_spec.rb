require 'spec_helper'

describe Site do
  let(:site) { Site.sample }

  it "keeps the days it's active in a set" do
    site.days = Set.new
    site.days << Site::Wednesday
    site.days << Site::Monday
    site.days << Site::Friday

    site.save!
    site.reload

    site.days.should eq [Site::Monday, Site::Wednesday, Site::Friday].to_set
  end

  it "displays the days it's active as a sentence" do
    site.days = Set.new
    site.days << Site::Friday
    site.days << Site::Tuesday
    site.days << Site::Saturday

    site.save!
    site.reload

    site.day_names.should eq 'tuesday, friday, and saturday'
  end
end
