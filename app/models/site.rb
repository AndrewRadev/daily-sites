class Site < ActiveRecord::Base
  belongs_to :user

  validates :title, :url, :user, :presence => true
  validates :url, :format => URI.regexp(['http', 'https', 'file'])

  Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday = (1 .. 7).to_a

  DayNames = {
    Monday    => 'monday',
    Tuesday   => 'tuesday',
    Wednesday => 'wednesday',
    Thursday  => 'thursday',
    Friday    => 'friday',
    Saturday  => 'saturday',
    Sunday    => 'sunday',
  }

  # TODO work around the "0" and "1" that come from the checkbox
  DayNames.each do |day, day_name|
    define_method "#{day_name}=" do |yes|
      if yes.to_i > 0
        # TODO: It needs to be initialized here, not sure why
        self.days ||= Set.new
        self.days << day
      else
        self.days.delete(day)
      end
    end

    define_method day_name do
      self.days.include? day
    end
  end

  serialize :days

  def days
    super or (self.days = Set.new)
  end

  def days=(v)
    super(v.try(:to_set))
  end

  def day_names
    if days == [Saturday, Sunday].to_set
      'Weekends'
    elsif days == (Monday .. Friday).to_set
      'Weekdays'
    elsif days == (Monday .. Sunday).to_set
      'Every day'
    else
      days.to_a.sort.map { |d| DayNames[d].capitalize }.to_sentence
    end
  end

  class << self
    def day_names_for_select
      DayNames.invert
    end

    def for_day(day)
      Site.order('title').all.select do |s|
        s.days.include? day
      end
    end

    def for_time(time)
      for_day(time.cwday)
    end
  end
end
