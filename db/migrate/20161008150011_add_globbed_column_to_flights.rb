class AddGlobbedColumnToFlights < ActiveRecord::Migration[4.2]
  def change
    add_column :flights, :globbed, :boolean, :default => false
  end
end
