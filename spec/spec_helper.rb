require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path('../../config/environment', __FILE__)
  require 'rspec/rails'

  ActiveSupport::Dependencies.clear
end

Spork.each_run do
  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
  Dir[Rails.root.join("spec/factories/**/*.rb")].each { |f| require f }

  DailySites::Application.reload_routes!

  RSpec.configure do |config|
    config.use_transactional_fixtures = true
    config.mock_with :rspec
  end
end
