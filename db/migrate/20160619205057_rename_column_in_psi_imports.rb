class RenameColumnInPsiImports < ActiveRecord::Migration[4.2]
  def change
  	rename_column :psi_imports, :type, :ac_model
  end
end
