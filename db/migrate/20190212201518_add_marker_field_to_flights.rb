class AddMarkerFieldToFlights < ActiveRecord::Migration[5.0]
  def change
    add_column :flights,:marked,:bool
  end
end
