# frozen_string_literal: true

class CreateTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :tokens, id: :uuid do |t|
      t.string :key
      t.datetime :expires_at
      t.boolean :active, default: true

      t.timestamps
    end

    add_index :tokens, :key, unique: true
    add_index :tokens, :expires_at
  end
end
