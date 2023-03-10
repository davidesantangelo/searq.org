# frozen_string_literal: true

module Api
  class SearchController < BaseController
    before_action :check_params

    def index
      @pagy, @items = pagy_array(hits)

      json_response_with_custom_serializer(@items, 'ItemSerializer')
    end

    private

    def permitted_params
      params.permit(:q, :sort, :direction, :limit).with_defaults(
        sort: 'published_at',
        direction: 'desc',
        limit: 1000,
        offset: 0
      )
    end

    def hits
      Item.search(permitted_params[:q], options)
    end

    def options
      {
        limit: permitted_params[:limit].to_i,
        offset: permitted_params[:offset].to_i,
        sort: ["#{permitted_params[:sort]}:#{permitted_params[:direction]}"]
      }
    end

    def check_params
      return if permitted_params[:q].present?

      json_error_response('Validation Failed', 'missing q param',
                          :unprocessable_entity)
    end
  end
end
