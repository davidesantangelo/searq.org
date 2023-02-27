# frozen_string_literal: true

module Api
  class NotAuthenticated < StandardError; end
  class BaseController < ActionController::Base
    include ::ActionController::Cookies
    include ActionController::HttpAuthentication::Token::ControllerMethods
    include Response
    include ExceptionHandler
    include Pagy::Backend

    Pagy::DEFAULT[:headers] = { page: 'Current-Page', items: 'Per-Page', pages: false, count: 'Total' }

    before_action :authenticate!, except: %i[info]
    skip_before_action :verify_authenticity_token

    def current_token
      @current_token ||= authenticate_request
    end

    def authenticate!
      authenticate_request || render_unauthorized('Token provided is invalid or expired')
    end

    def info
      render json: {
        version: '1.0.0',
        feeds_count: Feed.count,
        items_count: Feed.sum(:items_count),
        endpoints: api_endpoints.compact
      }
    end

    private

    def api_endpoints
      Rails.application.routes.routes.map do |route|
        next unless route.defaults[:controller].to_s.starts_with?('api/')

        {
          path: route.path.spec.to_s,
          verb: route.verb
        }
      end
    end

    def render_unauthorized(message)
      json_error_response(NotAuthenticated, message, :unauthorized)
    end

    def authenticate_request
      authenticate_with_http_token do |token, _|
        if (api_token = Token.active.find_by(key: token))
          # Compare the tokens in a time-constant manner, to mitigate timing attacks.
          ActiveSupport::SecurityUtils.secure_compare(
            ::Digest::SHA256.hexdigest(token),
            ::Digest::SHA256.hexdigest(api_token.key)
          )
          api_token
        end
      end
    end

    def render(*args, &block)
      pagy_headers_merge(@pagy) if @pagy
      super
    end
  end
end
