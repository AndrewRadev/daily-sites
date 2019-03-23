require 'rails_helper'

RSpec.describe Site do
  let(:site) { create(:site) }

  it "validates the correctness of the url" do
    site.url = 'invalid'
    expect(site).to be_invalid

    site.url = 'http://example.com'
    expect(site).to be_valid
  end

  it "keeps the days it's active in a set" do
    site = create(:site, days: [Site::Wednesday, Site::Monday, Site::Friday])

    site.save!
    site.reload

    expect(site.days).to eq [Site::Monday, Site::Wednesday, Site::Friday].to_set
  end

  describe "#day_names" do
    it "formats the days it's active as a sentence" do
      site = create(:site, days: [Site::Friday, Site::Tuesday, Site::Saturday])
      expect(site.day_names).to eq 'Tuesday, Friday, and Saturday'
    end

    it "uses something specific for weekends" do
      site = create(:site, days: [Site::Saturday, Site::Sunday])
      expect(site.day_names).to eq 'Weekends'
    end

    it "uses something specific for weekdays" do
      site = create(:site, days: (Site::Monday .. Site::Friday).to_set)
      expect(site.day_names).to eq 'Weekdays'
    end

    it "uses something specific for everyday sites" do
      site = create(:site, days: (Site::Monday .. Site::Sunday).to_set)
      expect(site.day_names).to eq 'Every day'
    end
  end

  it "retrieves sites, scheduled for a specific day" do
    weekdays = create(:site, days: Site::Monday .. Site::Friday)
    weekends = create(:site, days: [Site::Saturday, Site::Sunday])

    sunday = Date.parse('2011-05-01')
    expect(Site.for_time(sunday)).to include weekends
    expect(Site.for_time(sunday)).to_not include weekdays

    monday = Date.parse('2011-05-02')
    expect(Site.for_time(monday)).not_to include weekends
    expect(Site.for_time(monday)).to include weekdays

    wednesday = Date.parse('2011-05-04')
    expect(Site.for_time(wednesday)).to_not include weekends
    expect(Site.for_time(wednesday)).to include weekdays
  end

  it "allows adding days one by one by appending to #days" do
    site = create(:site, days: nil)

    expect(site.days).to be_empty
    site.days << Site::Monday
    expect(site.days.length).to eq 1
  end

  it "allows adding days one by one with a boolean flag" do
    site = create(:site, days: nil)
    expect(site.days).to be_empty

    site.monday = 1
    expect(site.days.length).to eq 1
    expect(site.days).to include Site::Monday

    site.tuesday = 1
    expect(site.days.length).to eq 2
    expect(site.days).to include Site::Tuesday

    site.friday = 1
    expect(site.days.length).to eq 3
    expect(site.days).to include Site::Friday

    site.monday = 0
    expect(site.days.length).to eq 2
    expect(site.days).to_not include Site::Monday
  end

  it "allows mass-assigning days" do
    attrs = create(:site, days: nil).attributes
    site = Site.new(attrs.merge(monday: '1', tuesday: '1', friday: '1'))

    expect(site).to be_valid
    expect(site.days).to eq [Site::Monday, Site::Tuesday, Site::Friday].to_set
  end

  it "allows checking whether it's active for a specific day" do
    site = create(:site, days: [Site::Monday, Site::Thursday, Site::Friday])

    expect(site.monday).to be_truthy
    expect(site.tuesday).to be_falsey
    expect(site.wednesday).to be_falsey
    expect(site.thursday).to be_truthy
    expect(site.friday).to be_truthy
  end
end
