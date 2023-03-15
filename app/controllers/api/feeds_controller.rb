# frozen_string_literal: true

module Api
  class FeedsController < BaseController
    before_action :set_feed, only: %i[show tasks update]
    before_action :check_create_params, only: :create
    before_action :create_feed, only: :create
    before_action :check_search_params, only: :search

    def index
      @pagy, @feeds = pagy(Feed.all)

      json_response_with_serializer(@feeds)
    end

    def create
      @task = @feed.store!

      json_response_with_serializer(@task)
    end

    def update
      @task = @feed.synchronize!

      json_response_with_serializer(@task)
    end

    def search
      @pagy, @feeds = pagy_array(hits)

      json_response_with_custom_serializer(@feeds, 'FeedSerializer')
    end

    def show
      json_response_with_serializer(@feed)
    end

    def tasks
      @pagy, @tasks = pagy(@feed.tasks)

      json_response_with_serializer(@tasks)
    end

    private

    def create_feed
      @feed = FeedManager::Create.new(url: params[:url]).call
    end

    def hits
      Feed.search(params[:q], options)
    end

    def options
      {
        limit: 1000
      }
    end

    def check_create_params
      json_error_response('Validation Failed', 'missing URL param', :unprocessable_entity) unless params[:url].present?
    end

    def check_search_params
      json_error_response('Validation Failed', 'missing q param', :unprocessable_entity) unless params[:q].present?
    end

    def set_feed
      @feed = Feed.find(params[:id])
    end
  end
end
