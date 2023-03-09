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
      Timeout.timeout(1.minutes.in_seconds) do
        response = HTTParty.get(feed_url).response

        code = response.code.to_i

        case code
        when 200
          response.body
        when 301, 302
          HTTParty.get(response.headers['location']).response.body
        when 403
          RestClient.get(feed_url).body
        else
          raise code
        end
      end
    end

    def feed_url
      url.gsub('feed://', '').gsub('feed:', '').squish
    end
  end
end
