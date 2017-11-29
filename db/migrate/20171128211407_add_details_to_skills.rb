class AddDetailsToSkills < ActiveRecord::Migration[5.1]
  def change
    add_column :skills, :location, :string
    add_column :skills, :latitude, :float
    add_column :skills, :longitude, :float
    add_column :skills, :formatted_address, :string
  end
end
