class AddApprColumnToPsiImport < ActiveRecord::Migration[4.2]
  def change
    add_column :psi_imports, :appr, :float
  end
end
