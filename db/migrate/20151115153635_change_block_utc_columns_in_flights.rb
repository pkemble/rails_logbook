class ChangeBlockUtcColumnsInFlights < ActiveRecord::Migration
  def change
    change_column :flights, :block_out_utc, :time
    change_column :flights, :block_in_utc, :time
  end
end
