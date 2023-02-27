# frozen_string_literal: true

class Feed < ApplicationRecord
  include MeiliSearch::Rails
  extend Pagy::Meilisearch

  has_many :items, dependent: :destroy
  has_many :tasks, dependent: :destroy

  # validations
  validates :url, presence: true, uniqueness: true
  validates :title, presence: true
  validates_associated :items

  meilisearch do
    attribute :title, :description, :language, :url
  end

  def store!
    task = tasks.enqueued.create!(task_type: :feed_store, enqueued_at: Time.current)

    FeedJob::Store.perform_async(task.id)

    task
  end

  def fetch!
    task = tasks.enqueued.create!(task_type: :feed_update, enqueued_at: Time.current)

    FeedJob::Update.perform_async(task.id)

    task
  end
end
