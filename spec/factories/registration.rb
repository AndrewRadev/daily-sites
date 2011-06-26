Factory.define(:registration) do |r|
  r.sequence(:uid) { |n| "#{n}" }
  r.provider 'twitter'

  r.association(:user)
end
