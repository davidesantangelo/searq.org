# frozen_string_literal: true

FactoryBot.define do
  factory :feed do
    id { SecureRandom.uuid }
    title { Faker::Book.title }
    description { Faker::Lorem.paragraph }
    url { Faker::Internet.url }
    items_count { rand(1..10) }
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
