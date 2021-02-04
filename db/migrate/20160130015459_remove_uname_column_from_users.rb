class RemoveUnameColumnFromUsers < ActiveRecord::Migration[4.2]
  def change
    remove_column :users, :uname  
  end
end
