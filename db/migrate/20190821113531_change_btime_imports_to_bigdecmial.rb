class ChangeBtimeImportsToBigdecmial < ActiveRecord::Migration[5.0]
  def up
    change_column :psi_imports, :btime, :decimal, :precision => 8, :scale => 1
  end
  
  def down
    change_column :psi_imports, :btime, :float
  end
end
