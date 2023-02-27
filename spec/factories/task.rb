# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    id { SecureRandom.uuid }
    task_type { 'feed_store' }
    enqueued_at { Time.current }
    finished_at { Time.current }
    status { 'enqueued' }
    started_at { Time.current }
    feed
  end
end
