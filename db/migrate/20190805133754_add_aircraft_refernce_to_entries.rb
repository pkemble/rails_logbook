class AddAircraftRefernceToEntries < ActiveRecord::Migration[5.0]
  def change
    add_reference :entries, :aircraft, index: true
    add_foreign_key :entries, :aircraft, column: :aircraft_id
  end
end
