class FlightsController < ApplicationController
  require 'stringutil'
  
	def new
		@flight = Flight.new
		@entry = Entry.find(params[:entry_id])
	end
	
	def show
	  @entry = Entry.find(params[:entry_id])
	end
	
	def create
		@entry = Entry.find(params[:entry_id])
		@flight = @entry.flights.new(flight_params)
		if @flight.save
		  redirect_to new_entry_flight_path, notice: "Flight saved"
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
	  @entry = Entry.find(params[:entry_id])
	  @flight = Flight.find(params[:id])
	  @flight.destroy
	  redirect_to edit_entry_path(@entry)
	end
	
	private
		def flight_params
			params.require(:flight).permit(:dep,:arr,:blockout,:blockin,:total_time,:block_out_utc,:block_in_utc)
		end
end
