class AddTurbopropColumnToAircraft < ActiveRecord::Migration[5.0]
  def change
    add_column :aircraft, :turboprop, :boolean
  end
end
