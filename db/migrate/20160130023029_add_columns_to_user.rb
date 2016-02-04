class AddColumnsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :def_tail_number, :string
  	add_column :users, :def_flight_number, :string
  end
end
