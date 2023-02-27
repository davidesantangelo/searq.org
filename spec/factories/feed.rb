# frozen_string_literal: true

FactoryBot.define do
  factory :feed do
    id { SecureRandom.uuid }
    title { 'feed RSS title' }
    description { 'feed RSS description' }
    url { 'http://url/rss2.0.xml' }
    items_count { 0 }
  end

  trait :with_items do
    after(:create) do |feed|
      create_list(:item, 3, feed:)
    end
  end

  trait :with_tasks do
    after(:create) do |feed|
      create_list(:task, 3, feed:)
    end
  end
end
