class AddBlockTimesToFlights < ActiveRecord::Migration
  def change
    add_column :flights, :p_blockout, :time
    add_column :flights, :p_blockin, :time
  end
end
