class AddColumnsToAirports < ActiveRecord::Migration[5.0]
  def change
    add_column :airports, :state, :string
    rename_column :airports, :elev, :elevation
  end
end
