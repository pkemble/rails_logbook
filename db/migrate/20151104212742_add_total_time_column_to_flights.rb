class AddTotalTimeColumnToFlights < ActiveRecord::Migration[4.2]
  def change
    add_column :flights, :total_time, :float
  end
end
