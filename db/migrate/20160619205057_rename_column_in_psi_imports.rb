class RenameColumnInPsiImports < ActiveRecord::Migration
  def change
  	rename_column :psi_imports, :type, :ac_model
  end
end
