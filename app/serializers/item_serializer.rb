# frozen_string_literal: true

class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :text, :url, :published_at, :published_at_timestamp, :categories
  belongs_to :feed
end
