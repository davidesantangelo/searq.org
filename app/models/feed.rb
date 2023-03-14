# frozen_string_literal: true

class Feed < ApplicationRecord
  include MeiliSearch::Rails
  extend Pagy::Meilisearch

  # associations
  has_many :items, dependent: :destroy
  has_many :tasks, dependent: :destroy

  # validations
  validates :url, presence: true, uniqueness: true
  validates :title, presence: true
  validates_associated :items

  # scopes
  scope :to_synchronize, -> { where('synchronized_at < ?', 8.hours.ago).or(where(synchronized_at: nil)) }

  # search
  meilisearch do
    attribute :title, :description, :language, :url
  end

  def self.to_csv
    attributes = %w[url title description language items_count]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |feed|
        csv << attributes.map { |attr| feed.send(attr) }
      end
    end
  end

  def store!
    task = tasks.enqueued.create!(task_type: :feed_store, enqueued_at: Time.current)

    FeedJob::Store.perform_async(task.id)

    task
  end

  def synchronize!
    task = tasks.enqueued.create!(task_type: :feed_update, enqueued_at: Time.current)

    FeedJob::Update.perform_async(task.id)

    task
  end
end
