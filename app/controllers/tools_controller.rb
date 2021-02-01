class ToolsController < ApplicationController
  def index
    @missing = Airport.where(lat: nil).order(used: :desc).to_a
  end
  
  def populate_usage
    Airport.update_all(used: 0)
    @flights = Flight.all
    @flights.each do |f|
      @apt_used = f.dep.remove_icao
      @airport = (Airport.where(iata: @apt_used).or(Airport.where(icao: f.dep)).or(Airport.where(iata: f.dep))).first
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
  
  def glob_flights
    @user = current_user
    GlobLogger.debug "\n #{Time.now}\n"
    GlobLogger.debug "=========================================="
    GlobLogger.debug "Globbing flights for #{@user.name}"

    @user_entries = Entry.where(user_id: @user.id)
    @user_entries.each do |e|
      if e.flights.count > 1
        @f1 = e.flights[0]
        @f2 = e.flights[1]
        if @f1.blockin.nil? or @f2.blockin.nil?
          GlobLogger.debug e.id.to_s + " Entry flight's block times missing, moving on"
          next
        end
        if @f1.globbed == false && @f1.check_for_late_flights == true
          @blockin = DateTime.strptime(@f1.blockin, "%H%M")
          @next_blockout = DateTime.strptime(@f2.blockout, "%H%M")
          if (@blockin + 10.hours) < @next_blockout
            @f1.glob
          end
        end
      end
    end
    GlobLogger.debug "=========================================="
    redirect_to tools_path
  end
  
end
