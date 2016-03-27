class RenamePsiImportTableToPsiImports < ActiveRecord::Migration
  def change
    rename_table :psi_import, :psi_imports
  end
end
