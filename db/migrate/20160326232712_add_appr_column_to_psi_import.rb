class AddApprColumnToPsiImport < ActiveRecord::Migration
  def change
    add_column :psi_imports, :appr, :float
  end
end
