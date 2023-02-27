# frozen_string_literal: true

module FeedManager
  class Create < ApplicationService
    attr_reader :url

    def initialize(url:)
      @url = url
    end

    def call
      create_feed
    end

    def create_feed
      feed = FeedManager::Parse.new(url:).call

      Feed.find_or_create_by(url:) do |f|
        f.title = feed.title.to_s.squish
        f.description = feed.try(:description).to_s.squish
        f.image = feed.try(:image)
        f.language = feed.try(:language)
      end
    end
  end
end
