desc "Populate the database with fake data"
task :fake => :environment do
  User.destroy_all
  User.create! do |admin|
    admin.uid      = '96514539'
    admin.provider = 'twitter'
    admin.name     = 'Andrew'
  end

  5.times do
    user = User.create! do |user|
      user.name = Faker::Name.name
    end

    Registration.create! do |registration|
      registration.user     = user
      registration.provider = 'twitter'
      registration.uid      = Time.now.to_f.to_s + rand.to_s
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
