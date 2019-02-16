class AddRemarksFieldToFlights < ActiveRecord::Migration[5.0]
  def change
    add_column :flights, :remarks, :text
  end
end
