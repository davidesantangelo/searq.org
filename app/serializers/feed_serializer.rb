# frozen_string_literal: true

class FeedSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :url, :description, :image, :language, :items_count
end
