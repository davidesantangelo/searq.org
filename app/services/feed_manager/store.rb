# frozen_string_literal: true

module FeedManager
  class Store < ApplicationService
    attr_reader :feed

    def initialize(feed:)
      @feed = feed
    end

    def call
      store_feed
    end

    private

    def store_feed
      entries.each do |entry|
        ItemManager::Create.new(feed:, entry:).call
      end

      feed
    end

    def entries
      Entries.new(feed:).call
    end
  end
end
