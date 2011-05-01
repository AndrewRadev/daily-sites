class Site < ActiveRecord::Base
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

  serialize :days

  def days
    super or Set.new
  end

  def days=(v)
    super(v.to_set)
  end

  def day_names
    days.to_a.sort.map { |d| DayNames[d] }.to_sentence
  end

  class << self
    def for_today
      week_day = Date.today.cwday
      Site.all.select do |s|
        s.days.include? week_day
      end
    end
  end
end
