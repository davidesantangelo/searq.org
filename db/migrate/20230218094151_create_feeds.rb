# frozen_string_literal: true

class CreateFeeds < ActiveRecord::Migration[7.0]
  def change
    create_table :feeds, id: :uuid do |t|
      t.string :title
      t.text :description
      t.jsonb :image
      t.string :url
      t.string :language
      t.integer :items_count, default: 0
      t.jsonb :metadata, default: {}

      t.timestamps
    end

    add_index :feeds, :url, unique: true
    add_index :feeds, :language
    add_index :feeds, :metadata, using: :gin
  end
end
