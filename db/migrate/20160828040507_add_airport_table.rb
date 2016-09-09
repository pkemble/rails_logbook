class AddAirportTable < ActiveRecord::Migration
  def change
    create_table :airports do |t|
      t.string :name
      t.string :city
      t.string :iata
      t.string :icao
      t.string :lat
      t.string :lon
      t.integer :elev
      t.string :tz
      t.string :dst
      t.string :olsontz
    end
  end
end
