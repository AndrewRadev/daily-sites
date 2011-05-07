require 'spec_helper'

describe Site do
  let(:site) { Site.sample }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:url) }

  it "should validate the correctness of the url" do
    site.url = 'invalid'
    site.should be_invalid

    site.url = 'http://example.com'
    site.should be_valid
  end

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

  it "retrieves sites, scheduled for the current day" do
    weekdays = Site.make :days => (Site::Monday .. Site::Friday)
    weekends = Site.make :days => [Site::Saturday, Site::Sunday]

    Timecop.freeze Date.parse('2011-05-01') do # Sunday
      Site.for_today.should include weekends
      Site.for_today.should_not include weekdays
    end

    Timecop.freeze Date.parse('2011-05-04') do # Wednesday
      Site.for_today.should_not include weekends
      Site.for_today.should include weekdays
    end
  end
end
