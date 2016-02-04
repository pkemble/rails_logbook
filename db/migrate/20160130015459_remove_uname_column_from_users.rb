class RemoveUnameColumnFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :uname  
  end
end
