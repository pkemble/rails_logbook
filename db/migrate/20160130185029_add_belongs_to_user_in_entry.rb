class AddBelongsToUserInEntry < ActiveRecord::Migration[4.2]
  def change
  	add_column :entries, :user_id, :integer
  end
end
