class CreateFlights < ActiveRecord::Migration[4.2]
  def change
    create_table :flights do |t|
      t.text :dep
      t.text :arr
      t.integer :blockin
      t.integer :blockout
      t.references :entry, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
