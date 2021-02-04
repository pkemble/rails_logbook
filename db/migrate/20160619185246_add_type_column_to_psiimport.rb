class AddTypeColumnToPsiimport < ActiveRecord::Migration[4.2]
  def change
  	add_column :psi_imports, :type, :string
  end
end
