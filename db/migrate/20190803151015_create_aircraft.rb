class CreateAircraft < ActiveRecord::Migration[5.0]
  def change
    create_table :aircraft do |t|
      t.string :tail
      t.string :ac_model
      t.boolean :turb
      t.boolean :multi

      t.timestamps
    end
  end
end
