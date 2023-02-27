# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items, id: :uuid do |t|
      t.references :feed, null: false, foreign_key: true, type: :uuid
      t.string :title
      t.text :body
      t.string :url
      t.string :external_id
      t.string :categories, array: true, default: []
      t.datetime :published_at
      t.jsonb :metadata, default: {}

      t.timestamps
    end

    add_index :items, :categories, using: 'gin'
    add_index :items, :url, unique: true
    add_index :items, :external_id
    add_index :items, %i[feed_id external_id], unique: true
    add_index :items, %i[feed_id published_at]
    add_index :items, :metadata, using: :gin
  end
end
