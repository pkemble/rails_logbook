class AddBoutBinColumnsToPsiImports < ActiveRecord::Migration
  def change
    add_column :psi_imports, :bout, :string
    add_column :psi_imports, :bin, :string
  end
end
