# frozen_string_literal: true

class Task < ApplicationRecord
  # associations
  belongs_to :feed

  # validations
  validates :feed, presence: true

  # scopes
  scope :newest, -> { order(created_at: :desc) }
  scope :oldest, -> { order(created_at: :asc) }

  # enums
  enum status: {
         enqueued: "enqueued",
         processing: "processing",
         succeeded: "succeeded",
         failed: "failed",
         canceled: "canceled"
       }

  enum task_type: { feed_store: "feedStore", feed_update: "feedUpdate" }

  # callbacks
  after_update :set_finished_at, if: :saved_change_to_status?
  after_update :set_started_at, if: :saved_change_to_status?

  # scopes
  scope :finished, -> { where.not(finished_at: nil) }
  scope :unfinished, -> { where(finished_at: nil) }

  # methods
  store :metadata, accessors: [:error_message], coder: JSON

  def set_started_at
    update(started_at: Time.current) if processing?
  end

  def set_finished_at
    update(finished_at: Time.current) if succeeded?
  end
end
