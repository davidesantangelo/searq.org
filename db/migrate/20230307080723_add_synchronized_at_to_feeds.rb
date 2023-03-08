# frozen_string_literal: true

class AddSynchronizedAtToFeeds < ActiveRecord::Migration[7.0]
  def change
    add_column :feeds, :synchronized_at, :datetime
    add_index :feeds, :synchronized_at
  end
end
