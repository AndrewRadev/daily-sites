FactoryBot.define do
  factory :user do
    name { 'joe' }

    after(:build) do |user, evaluator|
      user.registrations << FactoryBot.create(:registration, :user => user)
    end
  end
end
