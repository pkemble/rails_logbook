class AddPerDiemColumnToEntry < ActiveRecord::Migration[4.2]
  def change
    add_column :entries, :per_diem_hours, :float
  end
end
