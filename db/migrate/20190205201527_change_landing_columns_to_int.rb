class ChangeLandingColumnsToInt < ActiveRecord::Migration[5.0]
  def change
    change_column :flights, :night_ld, :int
    change_column :flights, :night_to, :int
    add_column :flights, :day_ld, :int
    add_column :flights, :day_to, :int
  end
end
