class RenameColumnInEntries < ActiveRecord::Migration
  def change
  	rename_column :entries, :type, :ac_model
  end
end
