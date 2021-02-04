class ChangeDateColumnPsiImport < ActiveRecord::Migration[4.2]
  def up
    change_column :psi_imports, :date, :string
  end

  def down
    change_column :psi_imports, :date, :date
  end
end
