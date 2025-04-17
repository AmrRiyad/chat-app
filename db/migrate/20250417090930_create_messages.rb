class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.integer :number
      t.string :content
      t.references :chat, null: false, foreign_key: true

      t.timestamps
    end
  end
end
