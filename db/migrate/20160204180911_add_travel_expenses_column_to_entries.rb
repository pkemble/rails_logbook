class AddTravelExpensesColumnToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :travel_expenses, :decimal, :precision => 8, :scale => 2
  end
end
