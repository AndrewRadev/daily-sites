desc "Populate the database with fake data"
task :fake => :environment do
  User.create! do |admin|
    admin.uid      = '96514539'
    admin.provider = 'twitter'
    admin.name     = 'Andrew'
  end

  5.times do
    User.create! do |user|
    end
  end

  users = User.all

  50.times do
    Site.create! do |site|
      site.title = Faker::Lorem.words(3).join(' ')
      site.url   = "http://#{Faker::Internet.domain_name}"

      site.days = []
      (1 .. 7).each do |day|
        site.days << day if [true, false].sample
      end

      site.user = users.sample
    end
  end
end
