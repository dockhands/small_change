class AddLocationToDeeds < ActiveRecord::Migration[5.2]
  def change
    add_column :deeds, :latitude, :float
    add_column :deeds, :longitude, :float
    add_column :deeds, :city, :string
    add_column :deeds, :address, :string
  end
end
