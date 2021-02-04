class RenamePsiImportTableToPsiImports < ActiveRecord::Migration[4.2]
  def change
    rename_table :psi_import, :psi_imports
  end
end
