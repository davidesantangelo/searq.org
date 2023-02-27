# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks, id: :uuid do |t|
      t.references :feed, null: false, foreign_key: true, type: :uuid
      t.string :status, null: false, default: 'enqueued'
      t.string :task_type, null: false
      t.datetime :started_at
      t.datetime :finished_at
      t.datetime :enqueued_at
      t.jsonb :metadata, default: {}
      t.timestamps
    end

    add_index :tasks, :status
    add_index :tasks, :started_at
    add_index :tasks, :finished_at
    add_index :tasks, :enqueued_at
    add_index :tasks, :task_type
    add_index :tasks, :metadata, using: :gin
  end
end
