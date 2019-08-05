class RemoveDefTailFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :def_tail_number, :string
  end
end
