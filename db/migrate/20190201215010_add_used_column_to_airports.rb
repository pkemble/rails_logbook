class AddUsedColumnToAirports < ActiveRecord::Migration[5.0]
  def change
    add_column :airports, :used, :int
  end
end
