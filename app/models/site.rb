class Site < ActiveRecord::Base
  Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday = [1, 2, 3, 4, 5, 6, 7]

  serialize :days

  def days
    super or Set.new
  end
end
