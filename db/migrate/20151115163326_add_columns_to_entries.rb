class AddColumnsToEntries < ActiveRecord::Migration[4.2]
  def change
    add_column :entries, :pic, :bool
    add_column :entries, :crew_name, :string
    add_column :entries, :crew_meal, :int
    add_column :entries, :tips, :decimal, :precision => 8, :scale => 2
    add_column :entries, :remarks, :text
  end
end
