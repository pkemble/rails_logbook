class AddBlockTimesToFlights < ActiveRecord::Migration
  def change
    add_column :flights, :block_out_utc, :date
    add_column :flights, :block_in_utc, :date
  end
end
