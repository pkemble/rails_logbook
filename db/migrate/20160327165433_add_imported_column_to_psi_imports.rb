class AddImportedColumnToPsiImports < ActiveRecord::Migration[4.2]
  def change
    add_column :psi_imports, :imported, :boolean
  end
end
