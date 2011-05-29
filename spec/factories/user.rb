Factory.define(:user) do |u|
  u.sequence(:uid) { |n| "#{n}" }
  u.provider 'twitter'
  u.name 'joe'
end
