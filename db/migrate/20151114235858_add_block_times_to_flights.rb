class AddBlockTimesToFlights < ActiveRecord::Migration
  def change
    add_column :flights, :p_blockout, :date
    add_column :flights, :p_blockin, :date
  end
end
