class ChangeDepArrToIds < ActiveRecord::Migration[6.1]
  def change
		change_column :flights, :dep, :int
		change_column :flights, :arr, :int
		rename_column :flights, :dep, :dep_id
		rename_column :flights, :arr, :arr_id
  end
end
