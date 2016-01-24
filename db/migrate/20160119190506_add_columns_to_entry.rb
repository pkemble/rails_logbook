class AddColumnsToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :per_diem_start, :datetime
    add_column :entries, :per_diem_end, :datetime
  end
end
