class AddDetailsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :location, :string
    add_column :users, :longitude, :float
    add_column :users, :latitude, :float
    add_column :users, :teacher_rating, :string
    add_column :users, :photo, :string
    add_column :users, :bio, :text
    add_column :users, :role, :string
  end
end
