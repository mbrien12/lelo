class AddMonetizeToSkills < ActiveRecord::Migration[5.1]
  def change
    remove_column :skills, :price, :integer
    add_monetize :skills, :price, currency: { present: false }
  end
end
