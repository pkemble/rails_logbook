class AddTotalTimeColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :total_time, :float
    add_column :users, :night_curr, :float
    
  end
end
