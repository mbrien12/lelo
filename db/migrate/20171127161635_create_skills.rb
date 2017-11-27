class CreateSkills < ActiveRecord::Migration[5.1]
  def change
    create_table :skills do |t|
      t.string :name
      t.integer :price
      t.text :description
      t.string :availability
      t.string :category
      t.string :skill_rating

      t.timestamps
    end

    add_reference :skills, :teacher, references: :users, index: true
    add_foreign_key :skills, :users, column: :teacher_id
  end
end
