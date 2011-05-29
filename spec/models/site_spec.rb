require 'spec_helper'

describe Site do
  let(:site) { Factory(:site) }

  it { should belong_to(:user) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:url) }

  it "should validate the correctness of the url" do
    site.url = 'invalid'
    site.should be_invalid

    site.url = 'http://example.com'
    site.should be_valid
  end

  it "keeps the days it's active in a set" do
    site = Factory(:site, :days => [Site::Wednesday, Site::Monday, Site::Friday])

    site.save!
    site.reload

    site.days.should eq [Site::Monday, Site::Wednesday, Site::Friday].to_set
  end

  describe "#day_names" do
    it "formats the days it's active as a sentence" do
      site = Factory(:site, :days => [Site::Friday, Site::Tuesday, Site::Saturday])
      site.day_names.should eq 'Tuesday, Friday, and Saturday'
    end

    it "uses something specific for weekends" do
      site = Factory(:site, :days => [Site::Saturday, Site::Sunday])
      site.day_names.should eq 'Weekends'
    end

    it "uses something specific for weekdays" do
      site = Factory(:site, :days => (Site::Monday .. Site::Friday).to_set)
      site.day_names.should eq 'Weekdays'
    end

    it "uses something specific for everyday sites" do
      site = Factory(:site, :days => (Site::Monday .. Site::Sunday).to_set)
      site.day_names.should eq 'Every day'
    end
  end

  it "retrieves sites, scheduled for a specific day" do
    weekdays = Factory(:site, :days => Site::Monday .. Site::Friday)
    weekends = Factory(:site, :days => [Site::Saturday, Site::Sunday])

    sunday = Date.parse('2011-05-01')
    Site.for_time(sunday).should include weekends
    Site.for_time(sunday).should_not include weekdays

    wednesday = Date.parse('2011-05-04')
    Site.for_time(wednesday).should_not include weekends
    Site.for_time(wednesday).should include weekdays
  end

  it "allows adding days one by one by appending to #days" do
    site = Factory(:site, :days => nil)

    site.days.should be_empty
    site.days << Site::Monday
    site.should have(1).days
  end

  it "allows adding days one by one with a boolean flag" do
    site = Factory(:site, :days => nil)
    site.days.should be_empty

    site.monday = 1
    site.should have(1).days
    site.days.should include Site::Monday

    site.tuesday = 1
    site.should have(2).days
    site.days.should include Site::Tuesday

    site.friday = 1
    site.should have(3).days
    site.days.should include Site::Friday

    site.monday = 0
    site.should have(2).days
    site.days.should_not include Site::Monday
  end

  it "allows mass-assigning days" do
    attrs = Factory(:site, :days => nil).attributes
    site = Site.new(attrs.merge(:monday => '1', :tuesday => '1', :friday => '1'))

    site.should be_valid
    site.days.should eq [Site::Monday, Site::Tuesday, Site::Friday].to_set
  end

  it "allows checking whether it's active for a specific day" do
    site = Factory(:site, :days => [Site::Monday, Site::Thursday, Site::Friday])

    site.monday.should be_true
    site.tuesday.should be_false
    site.wednesday.should be_false
    site.thursday.should be_true
    site.friday.should be_true
  end
end
