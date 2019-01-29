class ToolsController < ApplicationController
  def index
    @missing = Airport.where(lat: nil)
  end
  
  def night_report
    @missing = Airport.where(lat: nil)
    @output = Flight.all.select(:dep)
    render 'index'
  end
  
  def add_night
    @flights = Flight.all
  	@flights.each do |f|
  		f.add_night_time
  	end
  	redirect_to tools_path
  end
  
  def add_night_to_single_flight
    @flight = Flight.find(params[:flight_id])
    @flight.add_night_time
    redirect_to tools_path
  end
end
