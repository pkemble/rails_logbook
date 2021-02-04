class ChangeTotalColumnNames < ActiveRecord::Migration[4.2]
  def change
  	rename_column :flights, :total_time, :block_time
  end
end
