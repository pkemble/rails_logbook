class ToolsController < ApplicationController
  def index
    @missing = Airport.where(lat: nil).order(used: :desc).to_a
  end
  
  def populate_usage
    Airport.update_all(used: 0)
    @flights = Flight.all
    @flights.each do |f|
      @apt_used = f.dep.remove_icao
      @airport = Airport.where(iata: @apt_used).or(Airport.where(icao: @apt_used)).or(Airport.where(icao: f.dep)).first
      
      if @airport.nil?
        Airport.add_missing_airport(@apt_used, 1)
        next
      end
      @airport.used = @airport.used + 1
      @airport.save!
    end
    redirect_to tools_path
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
  		f.save
  	end
  	redirect_to tools_path
  end
  
  def add_night_to_single_flight
    @flight = Flight.find(params[:flight_id])
    @flight.add_night_time
    redirect_to tools_path
  end
  
  def calculate_xc
    Flight.update_all(distance: 0)
    @flights = Flight.all
    @flights.each do |f|
      f.check_for_xc
    end
    redirect_to tools_path
  end
  
  def add_xc_to_single_flight
    @flight = Flight.find(params[:flight_id])
    @flight.check_for_xc
    redirect_to tools_path
  end
end
