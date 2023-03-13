# frozen_string_literal: true

class CreateFlows < ActiveRecord::Migration[7.0]
  def change
    create_table :flows, id: :uuid do |t|
      t.text :query, null: false
      t.timestamps
    end
  end
end
