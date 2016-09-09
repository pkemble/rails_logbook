class ChangeTotalColumnNames < ActiveRecord::Migration
  def change
  	rename_column :flights, :total_time, :block_time
  end
end
