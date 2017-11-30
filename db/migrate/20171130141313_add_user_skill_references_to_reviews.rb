class AddUserSkillReferencesToReviews < ActiveRecord::Migration[5.1]
  def change
     add_reference :reviews, :skill, foreign_key: true
     add_reference :reviews, :student, references: :users
     add_foreign_key :reviews, :users, column: :student_id
  end
end
