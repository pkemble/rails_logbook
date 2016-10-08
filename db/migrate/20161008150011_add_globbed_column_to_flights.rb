class AddGlobbedColumnToFlights < ActiveRecord::Migration
  def change
    add_column :flights, :globbed, :boolean, :default => false
  end
end
