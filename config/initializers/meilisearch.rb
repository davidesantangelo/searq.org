# frozen_string_literal: true

MeiliSearch::Rails.configuration = {
  meilisearch_url: Rails.application.credentials.meilisearch[Rails.env][:url],
  meilisearch_api_key: Rails.application.credentials.meilisearch[Rails.env][:api_key]
}
