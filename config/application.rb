require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Nekonigohan
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    # config.load_defaults 6.1
    config.i18n.default_locale = :ja
    # Configuration for the application, engines, and railties goes here.
    Rails.application.config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins "*"  # すべてのオリジンからのリクエストを許可。セキュリティ上は具体的な許可範囲を設定したほうが良いです。
        resource "*", headers: :any, methods: [:get, :post, :put, :patch, :delete, :options]
      end
    end
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "Tokyo"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
