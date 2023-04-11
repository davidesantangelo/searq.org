class CreateCallbacks < ActiveRecord::Migration[7.0]
  def change
    create_table :callbacks, id: :uuid do |t|
      t.string :url, null: false
      t.string :events, null: false, array: true
      t.references :token, index: true, foreign_key: true, type: :uuid, null: false
      t.timestamps
    end

    add_index :callbacks, :url
    add_index :callbacks, %i[url token_id], unique: true
    add_index :callbacks, :events, using: 'gin'
  end
end
