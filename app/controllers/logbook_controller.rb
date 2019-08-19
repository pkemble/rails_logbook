class LogbookController < ApplicationController
  before_action :logged_in_user
  before_action :current_user
  
  @@flights_per_page = 33
  
  #require 'totals'
  require 'printpage'
  
  def index
    if !logged_in?
      redirect_back_or login_path
    end

    @totals = Totals::Totals.new
    @entries = Entry.where(user_id: current_user.id).order(:date).paginate(page: params[:page], per_page: 30)

    if params[:view].nil?
      @flights = Flight.where(user_id: current_user.id).joins(:entry).order('entries.date').order(:blockout).paginate(page: params[:page],
        per_page: 30)
    elsif params[:view] == "flights"
      @flights = Flight.where(user_id: current_user.id).joins(:entry).order('entries.date').order(:blockout).paginate(page: params[:page],
      per_page: 30)
    end
  end
  
  def print
    if !logged_in?
      redirect_back_or login_path
    end
    
    @flights = Flight.where(user_id: current_user.id).joins(:entry).order('entries.date').order(:blockout).limit(200)
    
    page = 1
    @page_array = Array.new #the entire document
    @running_total = Totals::PageTotals.new() # the running totals object
    @running_total = @running_total.add_previous_logbook_totals() #TODO Checkbox option?
    @page_flights = Array.new # a single re-usable page object
    @flights.in_groups_of(@@flights_per_page, false) do |flight_group|
      flight_group.each do |flight|
        @page_flights.append flight
      end
      @page_total = Totals::PageTotals.new() # the single page totals
      @page_total.get_page_totals(@page_flights)
      @running_total.add_to_running_total(@page_total) #cumulatively add the page totals to the running total
      @print_page = PrintPage.new() # a printable page object
      
      @page_flights.each do |pf|
        @print_page.flights ||= []
        @print_page.flights.append FlightSerializer.new(pf).as_json
      end
      
      @print_page.totals = @page_total
      @print_page.running_total = @running_total
      @page_array.append(@print_page.serialized) # add the printable page object to the entire document array
      @page_flights.clear # clear the single re-usable page object for the next 33 flights.
    end
    @json_page = @page_array.to_json
  end
end
