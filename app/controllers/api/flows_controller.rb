# frozen_string_literal: true

module Api
  class FlowsController < BaseController
    before_action :check_create_params, only: %i[create update]
    before_action :set_flow, only: %i[show update items]

    def index
      @pagy, @flows = pagy(Flow.all.order(created_at: :desc))

      json_response_with_serializer(@flows)
    end

    def create
      @flow = Flow.create(query: params[:query])

      json_response_with_serializer(@flow)
    end

    def update
      @flow.update(query: params[:query])

      json_response_with_serializer(@flow.reload)
    end

    def show
      json_response_with_serializer(@flow)
    end

    def items
      @pagy, @items = pagy_array(@flow.items)

      json_response_with_custom_serializer(@items, 'ItemSerializer')
    end

    private

    def set_flow
      @flow = Flow.find(params[:id])
    end

    def check_create_params
      return if params[:query].present?

      json_error_response('Validation Failed', 'missing query param',
                          :unprocessable_entity)
    end
  end
end
