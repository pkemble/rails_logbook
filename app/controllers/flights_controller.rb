class FlightsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user
  
  require 'stringutil'
  
  include FlightsHelper
  
	def new
		@flight = Flight.new
		@entry = Entry.find(params[:entry_id])
		@user = current_user
		@flight.dep = FlightsHelper.last_loc(@user, @entry)
	end
	
	def show
	  @entry = Entry.find(params[:entry_id])
	end
	
	def create
		@entry = Entry.find(params[:entry_id])
		@flight = @entry.flights.new(flight_params)
		if @flight.save
		  if params[:commit] == "Save and start next flight" # weak, but I can't see another option
		    flash[:success] = "Flight: #{@flight.dep} to #{@flight.arr} saved!"
		    redirect_to new_entry_flight_path  
		  else
		    redirect_to edit_entry_path(params[:entry_id])
		  end
		else
		  render 'new'  
		end
		
	end
	
	def edit
		@flight = Flight.find(params[:id])
		
	end
	
	def update
	  @flight = Flight.find(params[:id])
	  if @flight.update(flight_params)
	    redirect_to edit_entry_path(@flight.entry_id)
	  else
	    render 'edit'
	  end
	end
	
	def destroy
	  #@entry = Entry.find(params[:entry_id])
	  @flight = Flight.find(params[:id])
	  @flight.destroy
	  redirect_to edit_entry_path(@flight.entry_id)
	end
	
	private
		def flight_params
			params.require(:flight).permit(:dep,:arr,:blockout,:blockin,:total_time,:p_blockout,:p_blockin,
			:night_to,:night_ld,:night,:instrument,:approaches,:pf)
		end
		

end
