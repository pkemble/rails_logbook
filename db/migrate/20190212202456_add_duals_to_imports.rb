class AddDualsToImports < ActiveRecord::Migration[5.0]
  def change
    add_column :psi_imports, :dual_given, :bool
    add_column :psi_imports, :dual_recvd, :bool
  end
end
