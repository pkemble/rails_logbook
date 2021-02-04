class PsiImport < ActiveRecord::Migration[4.2]
  def change
    create_table :psi_import do |t|
      t.datetime :date
      t.string :dep
      t.string :arr
      t.text :tail
      t.integer :dto
      t.integer :nto
      t.integer :dlnd
      t.integer :nlnd
      t.float :btime
      t.float :ntime
      t.float :pictime
      t.float :sictime
      t.float :melpic
      t.float :melsic
      t.integer :holds
      t.string :pic
      t.string :sic
      
      t.timestamps null: false
    end
  end
end
