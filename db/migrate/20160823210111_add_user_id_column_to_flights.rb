class AddUserIdColumnToFlights < ActiveRecord::Migration
  def change
  	add_column :flights, :user_id, :integer
		
		say "populating user_id column in flights"
		  	
  	@entries = Entry.all
  	@entries.each do |e|
  		@flights = e.flights
  		@flights.each do |f|
  			f.update_attributes!(:user_id => e.user_id)
  		end
  	end
  end
end
