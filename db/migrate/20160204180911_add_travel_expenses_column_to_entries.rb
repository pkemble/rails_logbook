class AddTravelExpensesColumnToEntries < ActiveRecord::Migration[4.2]
  def change
    add_column :entries, :travel_expenses, :decimal, :precision => 8, :scale => 2
  end
end
