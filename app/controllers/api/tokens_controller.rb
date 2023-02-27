# frozen_string_literal: true

module Api
  class TokensController < BaseController
    skip_before_action :authenticate!, only: [:create]

    def create
      @token = Token.create!

      json_response_with_serializer(@token)
    end

    def refresh
      @token = current_token.refresh!

      json_response_with_serializer(current_token)
    end
  end
end
