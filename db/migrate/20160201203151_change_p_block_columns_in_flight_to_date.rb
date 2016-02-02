class ChangePBlockColumnsInFlightToDate < ActiveRecord::Migration
  def change
    remove_column :flights, :p_blockin, :time
    remove_column :flights, :p_blockout, :time
    
    add_column :flights, :p_blockin, :datetime
    add_column :flights, :p_blockout, :datetime  
  end

end
