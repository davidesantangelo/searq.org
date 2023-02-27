# frozen_string_literal: true

module FeedManager
  class Parse < ApplicationService
    attr_reader :url

    def initialize(url:)
      @url = url
    end

    def call
      parse_feed
    end

    private

    def parse_feed
      Feedjira.parse(body)
    end

    def body
      HTTParty.get(normalized_feed_url).body
    end

    def normalized_feed_url
      url.gsub('feed://', '').gsub('feed:', '').squish
    end
  end
end
