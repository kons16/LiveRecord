require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Liverecord
  class Application < Rails::Application
  	config.time_zone = 'Tokyo'
    config.load_defaults 5.1
    config.i18n.default_locale = :ja
    config.assets.initialize_on_precompile = false
  end
end
