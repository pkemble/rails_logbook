class AddTaaColumnsToAircraft < ActiveRecord::Migration[5.0]
  def change
    add_column :aircraft, :efis, :boolean
    add_column :aircraft, :fadec, :boolean
    add_column :aircraft, :glass, :boolean
  end
end
