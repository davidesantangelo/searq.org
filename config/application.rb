# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Searq
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.exceptions_app = routes
    config.active_record.schema_format = :sql

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: %i[get post put patch delete options head],
                      expose: %w[Current-Page Total Per-Page Link]
      end
    end

    config.assets.initialize_on_precompile = false

    config.middleware.use ActionDispatch::Cookies

    Rack::Attack.throttled_responder = lambda do |request|
      match_data = request.env['rack.attack.match_data']
      now = match_data[:epoch_time]

      headers = {
        'RateLimit-Limit' => match_data[:limit].to_s,
        'RateLimit-Remaining' => '0',
        'RateLimit-Reset' => (now + (match_data[:period] - now % match_data[:period])).to_s
      }

      [429, headers, ["Throttled\n"]]
    end

    Rack::Attack.throttled_response_retry_after_header = true

    config.middleware.use Rack::Attack
    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end
  end
end
