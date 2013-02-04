FactoryGirl.define do
  factory :user do
    name 'joe'

    after(:build) do |user, evaluator|
      user.registrations << FactoryGirl.create(:registration, :user => user)
    end
  end
end
