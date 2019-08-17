class ChangeBlocktimeToInt < ActiveRecord::Migration[5.0]
  def up
    change_column :flights, :block_time, :decimal, :precision => 8, :scale => 1
    change_column :flights, :night, :decimal, :precision => 8, :scale => 1
  end
  
  def down
    change_column :flights, :block_time, :float
    change_column :flights, :night, :float
  end
end
