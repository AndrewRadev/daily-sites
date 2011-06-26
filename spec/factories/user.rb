Factory.define(:user) do |u|
  u.name 'joe'

  u.after_build do |u|
    u.registrations << Factory(:registration, :user => u)
  end
end
