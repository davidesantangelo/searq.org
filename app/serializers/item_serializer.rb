# frozen_string_literal: true

class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title,
             :text,
             :url,
             :published_at,
             :published_at_timestamp,
             :categories,
             :sentiment,
             :enriched_at,
             :feed
  belongs_to :feed

  attribute :feed do |object|
    { id: object.feed.id, title: object.feed.title, url: object.feed.url }
  end
end
