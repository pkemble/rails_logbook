class CreateAircraft < ActiveRecord::Migration[5.0]
  def change
    create_table :aircraft do |t|
      t.string :tail
      t.string :ac_model
      t.boolean :turb, default: false
      t.boolean :multi, default: false
      t.boolean :turboprop, default: false
      t.boolean :efis, default: false
      t.boolean :glass, default: false
      t.boolean :fadec, default: false
      t.timestamps
    end
  end
end
