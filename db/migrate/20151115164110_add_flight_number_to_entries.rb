class AddFlightNumberToEntries < ActiveRecord::Migration[4.2]
  def change
    add_column :entries, :flight_number, :string
  end
end
