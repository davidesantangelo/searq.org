# frozen_string_literal: true

class Item < ApplicationRecord
  include ActionView::Helpers::SanitizeHelper
  include MeiliSearch::Rails
  extend Pagy::Meilisearch

  belongs_to :feed, counter_cache: true

  # validations
  validates :title, presence: true
  validates :url, presence: true, uniqueness: true
  validates :external_id, presence: true, uniqueness: true

  meilisearch do
    attribute :title, :text, :url, :categories, :published_at, :published_at_timestamp, :feed_id
    searchable_attributes %i[title text url categories published_at feed_id]

    filterable_attributes %i[feed_id categories published_at published_at_timestamp]
    sortable_attributes %i[published_at published_at_timestamp title]

    attribute :feed do
      feed.title
    end
  end

  def text
    strip_tags(body.presence || title).to_s.squish
  end

  def published_at_timestamp
    published_at.to_i
  end
end
