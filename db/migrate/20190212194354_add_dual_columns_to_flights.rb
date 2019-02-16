class AddDualColumnsToFlights < ActiveRecord::Migration[5.0]
  def change
    add_column :flights, :dual_given, :bool
    add_column :flights, :dual_recvd, :bool
  end
end
