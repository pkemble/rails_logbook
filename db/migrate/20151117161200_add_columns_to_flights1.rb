class AddColumnsToFlights1 < ActiveRecord::Migration[4.2]
  def change
    add_column :flights, :night_to, :boolean
    add_column :flights, :night_ld, :boolean
    add_column :flights, :night, :float
    add_column :flights, :instrument, :float
    add_column :flights, :approaches, :float
    add_column :flights, :pf, :boolean
  end
end
