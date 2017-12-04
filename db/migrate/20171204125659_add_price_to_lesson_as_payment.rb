class AddPriceToLessonAsPayment < ActiveRecord::Migration[5.1]
  def change
    remove_column :lessons, :price, :string
    add_monetize :lessons, :price, currency: { present: false }
  end
end
