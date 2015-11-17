class ChangeBlockUtcColumnsInFlights < ActiveRecord::Migration
  def change
    change_column :flights, :p_blockout, :time
    change_column :flights, :p_blockin, :time
  end
end
