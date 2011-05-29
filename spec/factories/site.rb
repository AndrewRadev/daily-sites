Factory.define(:site) do |s|
  s.title 'title'
  s.url 'http://example.com'

  s.association(:user)
end
