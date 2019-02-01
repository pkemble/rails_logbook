class AddXcColumnToFlights < ActiveRecord::Migration[5.0]
  def change
    add_column :flights, :xc, :bool
  end
end
