class AddImportedColumnToPsiImports < ActiveRecord::Migration
  def change
    add_column :psi_imports, :imported, :boolean
  end
end
