class ChangeImportedColumnDefault < ActiveRecord::Migration[5.0]
  def change
    change_column_default :psi_imports, :imported, false
  end
end
