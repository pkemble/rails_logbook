class CreateFlightLogCsvs < ActiveRecord::Migration
  def change
    create_table :flight_log_csvs do |t|
      t.date :string
      t.tail :string
      t.dep :string
      t.arr :string
      t.bout :string
      t.bin :string
      t.pic :string
      t.sic :string
      t.appr :decimal
      t.dland :decimal
      t.nland :decimal

      t.timestamps null: false
    end
  end
end
