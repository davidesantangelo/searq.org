module Api
  class WebhooksController < BaseController
    # callbacks
    before_action :set_webhook, only: %i[show update destroy]
    before_action :check_create_params, only: [:create]

    def index
      @pagy, webhooks = pagy callbacks

      json_response_with_serializer(webhooks)
    end

    def show
      json_response_with_serializer(@webhook)
    end

    def create
      @webhook = callbacks.create!(webhook_params)

      json_response_with_serializer(@webhook)
    end

    def update
      @webhook = callbacks.update(webhook_params)

      json_response_with_serializer(@webhook)
    end

    def destroy
      @webhook.destroy

      head :no_content
    end

    private

    def check_create_params
      unless webhook_params[:url].present?
        json_error_response('Validation Failed', 'missing URL param', :unprocessable_entity)
        return
      end

      return if webhook_params[:events].present?

      json_error_response('Validation Failed', "missing events param (#{Webhook::Event::EVENT_TYPES.join(',')})", :unprocessable_entity)
    end

    def set_webhook
      @webhook = callbacks.find(params[:id])
    end

    def callbacks
      current_token.callbacks
    end

    def webhook_params
      params.permit(:url, events: [])
    end
  end
end
