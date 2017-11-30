class AddReviewTable < ActiveRecord::Migration[5.1]
    def change
      create_table :reviews do |t|
      t.string :comment
      t.integer :rating
      t.timestamps
    end

    add_reference :skills, :teacher, :student, references: :users, index: true
    add_foreign_key :skills, :users, column: :teacher_id, :student_id
    end
  end
end
