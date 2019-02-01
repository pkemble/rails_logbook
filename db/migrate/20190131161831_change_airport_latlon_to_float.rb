class ChangeAirportLatlonToFloat < ActiveRecord::Migration[5.0]
  def change
    remove_column :airports, :lat
    add_column :airports, :lat, :float
    remove_column :airports, :lon
    add_column :airports, :lon, :float
  end
end
