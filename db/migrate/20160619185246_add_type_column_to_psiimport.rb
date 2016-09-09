class AddTypeColumnToPsiimport < ActiveRecord::Migration
  def change
  	add_column :psi_imports, :type, :string
  end
end
