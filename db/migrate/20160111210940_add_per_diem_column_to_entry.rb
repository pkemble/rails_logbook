class AddPerDiemColumnToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :per_diem_hours, :float
  end
end
