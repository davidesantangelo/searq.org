# frozen_string_literal: true

module Api
  class ItemsController < BaseController
    # callbacks
    before_action :set_feed
    before_action :set_feed_item, only: %i[show]

    def index
      @pagy, @items = pagy @feed.items

      json_response_with_serializer(@items)
    end

    def show
      json_response_with_serializer(@entry)
    end

    private

    def set_feed
      @feed = Feed.find(params[:feed_id])
    end

    def set_feed_item
      @item = @feed.items.find_by!(id: params[:id]) if @feed
    end
  end
end
