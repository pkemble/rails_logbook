class FlightsController < ApplicationController
  require 'stringutil'
  
	def new
		@flight = Flight.new
		@flight.dep = last_loc
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
	  #@entry = Entry.find(params[:entry_id])
	  @flight = Flight.find(params[:id])
	  @flight.destroy
	  redirect_to edit_entry_path(@flight.entry_id)
	end
	
	def last_loc
	  if !@flight.dep.nil?
	    return @flight.dep
	  end
    @entry = Entry.find(params[:entry_id])
    if @entry.flights.any?
      last_loc = @entry.flights.last.arr
    else
      #todo get the preceding entry/flight
      @entries = Entry.order('date')
      if @entries.count > 1
        self.last_loc = Entry.order('date').last(2)[0].flights.last.arr
      else
        self.last_loc = ""
      end
      
    end
  end
	
	private
		def flight_params
			params.require(:flight).permit(:dep,:arr,:blockout,:blockin,:total_time,:p_blockout,:p_blockin,
			:night_to,:night_ld,:night,:instrument,:approaches,:pf)
		end
		

end
