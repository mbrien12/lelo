class RemoveDetailsFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :location, :string
    remove_column :users, :formatted_address, :string
    remove_column :users, :longitude, :float
    remove_column :users, :latitude, :float
  end
end
