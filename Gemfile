source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails', '~> 5.2.2', '>= 5.2.2.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.12'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

gem 'bootstrap-sass'
gem 'jquery-rails'

gem 'omniauth'
gem 'omniauth-twitter'

# Fix potential CSRF issue (https://github.com/omniauth/omniauth/pull/809)
gem 'omniauth-rails_csrf_protection', '~> 0.1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development do
  gem 'faker', require: false
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'rspec-rails'
end

group :test do
  gem 'factory_bot'
  gem 'timecop'
end
