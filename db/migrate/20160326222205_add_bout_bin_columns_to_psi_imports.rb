class AddBoutBinColumnsToPsiImports < ActiveRecord::Migration[4.2]
  def change
    add_column :psi_imports, :bout, :string
    add_column :psi_imports, :bin, :string
  end
end
