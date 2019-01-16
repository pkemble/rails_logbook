class ChangeDateToBeDatetimeInPsiImport < ActiveRecord::Migration[5.0]
  def change
  	remove_column :psi_imports, :date
  	add_column :psi_imports, :date, :datetime
  end
end
