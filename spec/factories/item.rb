# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    id { SecureRandom.uuid }
    title { 'item title' }
    body { 'item body' }
    url { 'http://url/item' }
    external_id { SecureRandom.uuid }
    published_at { Time.now }
    feed
  end
end
