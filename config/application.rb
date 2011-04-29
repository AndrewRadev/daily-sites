require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env) if defined?(Bundler)

module DailySites
  class Application < Rails::Application
    # config.autoload_paths += %W(#{config.root}/extras)
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
    # config.time_zone = 'UTC'
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.action_view.javascript_expansions[:defaults] = %w()
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
  end
end
