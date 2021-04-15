class CreateQols < ActiveRecord::Migration[6.1]
  def change
    create_table :qols do |t|
      t.date :date
      t.string :month
      t.string :year
      t.string :tail
      t.string :legs
      t.float :pd
      t.float :amount
      t.float :total
      t.timestamps
    end
  end
end
