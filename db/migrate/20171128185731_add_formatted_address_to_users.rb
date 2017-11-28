class AddFormattedAddressToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :formatted_address, :string
  end
end
