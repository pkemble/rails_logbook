class ChangeDateColumnPsiImport < ActiveRecord::Migration
  def up
    change_column :psi_imports, :date, :string
  end

  def down
    change_column :psi_imports, :date, :date
  end
end
