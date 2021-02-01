class AddErrorColumnToImports < ActiveRecord::Migration[5.0]
  def change
    add_column :psi_imports, :import_errors, :string
  end
end
