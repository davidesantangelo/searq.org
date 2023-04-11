class AddEnrichFieldsToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :sentiment, :jsonb, default: {}
    add_column :items, :enriched_at, :datetime

    add_index :items, :enriched_at
    add_index :items, :sentiment, using: 'gin'
  end
end
