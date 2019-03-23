FactoryBot.define do
  factory :registration do
    sequence(:uid) { |n| "#{n}" }
    provider { 'twitter' }

    user
  end
end
