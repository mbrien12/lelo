class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :message_text
      t.references :skill, foreign_key: true

      t.timestamps
    end

    add_reference :messages, :student, references: :users, index: true
    add_foreign_key :messages, :users, column: :student_id
    add_reference :messages, :teacher, references: :users, index: true
    add_foreign_key :messages, :users, column: :teacher_id
  end
end
