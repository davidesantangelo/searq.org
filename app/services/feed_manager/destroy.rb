# frozen_string_literal: true

module FeedManager
  class Destroy < ApplicationService
    attr_reader :feed

    def initialize(feed:)
      @feed = feed
    end

    def call
      destroy_feed
    end

    private

    def destroy_feed
      feed.remove_from_index!
      feed.destroy!
    end
  end
end
