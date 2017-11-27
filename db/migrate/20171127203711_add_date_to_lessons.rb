class AddDateToLessons < ActiveRecord::Migration[5.1]
  def change
    add_column :lessons, :date, :date
  end
end
