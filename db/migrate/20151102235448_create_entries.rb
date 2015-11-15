class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.datetime :date
      t.text :tail

      t.timestamps null: false
    end
  end
end
