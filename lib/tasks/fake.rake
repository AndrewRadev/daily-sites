desc "Populate the database with fake data"
task :fake => :environment do
  20.times do
    Site.create! do |site|
      site.title = Faker::Lorem.words(3).join(' ')
      site.url   = "http://#{Faker::Internet.domain_name}"

      site.days = []
      (1 .. 7).each do |day|
        site.days << day if [true, false].sample
      end
    end
  end
end
