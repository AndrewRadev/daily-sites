source 'http://rubygems.org'

gem 'rails', '3.0.7'
gem 'rake', '~> 0.8.7'
gem 'sqlite3'
gem 'oa-oauth'

group :development do
  gem 'faker'
  gem 'nifty-generators'
end

group :development, :test do
  gem 'rspec-rails'

  gem 'guard-rspec'

  if RUBY_PLATFORM =~ /darwin/i
    gem 'rb-fsevent', :require => false
    gem 'growl',      :require => false
  else
    gem 'libnotify'
  end
end

group :test do
  gem 'sample_models'
  gem 'shoulda'
  gem 'timecop'
  gem 'spork'
end
