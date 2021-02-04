class RenameColumnInEntries < ActiveRecord::Migration[4.2]
  def change
  	add_column :entries, :ac_model, :string
  end
end
