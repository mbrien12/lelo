class CreateLessons < ActiveRecord::Migration[5.1]
  def change
    create_table :lessons do |t|
      t.references :skill, foreign_key: true
      t.string :name
      t.string :description
      t.boolean :completed
      t.boolean :paid
      t.string :price

      t.timestamps
    end

    add_reference :lessons, :student, references: :users, index: true
    add_foreign_key :lessons, :users, column: :student_id
  end
end
