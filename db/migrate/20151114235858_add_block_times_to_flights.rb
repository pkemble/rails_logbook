class AddBlockTimesToFlights < ActiveRecord::Migration[4.2]
  def change
    add_column :flights, :p_blockout, :time
    add_column :flights, :p_blockin, :time
  end
end
