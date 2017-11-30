class AddStatusToLessonsAndRemoveCompletedFromLessons < ActiveRecord::Migration[5.1]
  def change
    remove_column :lessons, :completed, :boolean
    add_column :lessons, :status, :string
  end
end
