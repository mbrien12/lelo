class AddChargeToLessons < ActiveRecord::Migration[5.1]
  def change
    add_column :lessons, :charge_id, :string
  end
end
