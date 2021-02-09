class FlightsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user
	before_action :force_json, only: :search_apt 

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
		fp = flight_params
		fp[:dep] = Airport.search(flight_params[:dep])
		fp[:arr] = Airport.search(flight_params[:arr])
		@flight = @entry.flights.new(fp)
		if @flight.save
		  if params[:commit] == "Save and start next flight" # weak, but I can't see another option
		    flash[:success] = "Flight: #{@flight.dep.name} to #{@flight.arr.name} saved!"
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
byebug
	  @flight = Flight.find(params[:id])
		fp = flight_params
		fp[:dep] = Airport.search(flight_params[:dep], true)
		fp[:arr] = Airport.search(flight_params[:arr], true)
	  if @flight.update(fp)
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

	def search_apt
		q = params[:q].upcase
		@apts = Airport.search_multiple(q)
	end
	
	def force_json
			request.format =:json
	end

	private
		def flight_params
			params.require(:flight).permit(:dep,:arr,:blockout,:blockin,:total_time,:p_blockout,:p_blockin, :day_to, :day_ld,
			:night_to,:night_ld,:night,:instrument,:approaches,:pf,:dual_given,:dual_recvd,:remarks,:marked)
		end
		

end
