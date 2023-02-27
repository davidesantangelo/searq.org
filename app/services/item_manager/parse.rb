# frozen_string_literal: true

module ItemManager
  class Parse < ApplicationService
    attr_reader :feed, :entry

    def initialize(feed:, entry:)
      @feed = feed
      @entry = entry
    end

    def call
      parse_item
    end

    private

    def categories
      entry&.categories.to_a.compact.map(&:downcase).map(&:strip)
    end

    def published_at
      entry.published || Time.current
    end

    def title
      entry.title.presence || 'untitled'
    end

    def parse_item
      attrs = {
        feed_id: feed.id,
        title:,
        body: entry.summary,
        url: entry.url,
        external_id: entry.entry_id,
        categories:,
        published_at:,
        created_at: Time.current,
        updated_at: Time.current
      }

      item = ::Item.new(attrs)

      return nil unless item.valid?

      item
    end
  end
end
