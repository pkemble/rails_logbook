class AddTotalTimeColumnToFlights < ActiveRecord::Migration
  def change
    add_column :flights, :total_time, :float
  end
end
