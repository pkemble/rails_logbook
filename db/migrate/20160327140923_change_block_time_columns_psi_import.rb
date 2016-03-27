class ChangeBlockTimeColumnsPsiImport < ActiveRecord::Migration
  def change
    rename_column :psi_imports, :bin, :blockin
    rename_column :psi_imports, :bout, :blockout
    rename_column :psi_imports, :nlnd, :night_ld
    rename_column :psi_imports, :appr, :approaches
  end
end
