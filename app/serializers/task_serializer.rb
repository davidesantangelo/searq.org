# frozen_string_literal: true

class TaskSerializer
  include FastJsonapi::ObjectSerializer
  attributes :status,
             :task_type,
             :enqueued_at,
             :started_at,
             :finished_at,
             :error_message
  belongs_to :feed
end
