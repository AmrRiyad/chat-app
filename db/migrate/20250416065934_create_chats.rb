class CreateChats < ActiveRecord::Migration[8.0]
  def change
    create_table :chats do |t|
      t.integer :number, null: false
      t.string :name, null: false

      t.references :application, null: false, foreign_key: true

    t.timestamps
    end
  end
end
