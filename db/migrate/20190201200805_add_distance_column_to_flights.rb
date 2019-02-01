class AddDistanceColumnToFlights < ActiveRecord::Migration[5.0]
  def change
    add_column :flights, :distance, :float
  end
end
