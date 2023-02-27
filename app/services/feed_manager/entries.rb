# frozen_string_literal: true

module FeedManager
  class Entries < ApplicationService
    attr_reader :feed

    def initialize(feed:)
      @feed = feed
    end

    def call
      entries
    end

    private

    def entries
      Parse.new(url: feed.url).call.entries
    rescue StandardError
      []
    end
  end
end
