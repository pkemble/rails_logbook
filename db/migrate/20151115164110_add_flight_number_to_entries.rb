class AddFlightNumberToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :flight_number, :string
  end
end
