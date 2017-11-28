class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :message_text
      t.references :skill, foreign_key: true

      t.timestamps
    end

    add_reference :messages, :sender, references: :users, index: true
    add_foreign_key :messages, :users, column: :sender_id
    add_reference :messages, :receiver, references: :users, index: true
    add_foreign_key :messages, :users, column: :receiver_id
  end
end
