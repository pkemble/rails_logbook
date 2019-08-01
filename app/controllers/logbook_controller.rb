class LogbookController < ApplicationController
  before_action :logged_in_user
  before_action :current_user
  
  require 'totals'
  require 'printpage'
  
  def index
    if !logged_in?
      redirect_back_or login_path
    end

    @totals = Totals.new
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
    
    @entries = Entry.where(user_id: current_user.id).order(:date)
    @flights = Flight.where(user_id: current_user.id).joins(:entry).order('entries.date').order(:blockout)
    
    page = 1
    @page_array = Array.new #the entire document
    @running_total = PageTotals.new() # the running totals object
    @page_flights = Array.new # a single re-usable page object
    @flights.each do |f|
      @page_flights.append f
      page += 1
      if page == 33 #make this a setting
        @page_total = PageTotals.new() # the single page totals
        @page_total.get_page_totals(@page_flights)
        @running_total.add_to_running_total(@page_total) #cumulatively add the page totals to the running total
        
        @print_page = PrintPage.new() # a printable page object
        @print_page.flights = @page_flights
        @print_page.totals = @page_total
        @print_page.running_total = @running_total
        @page_array.append(@print_page) # add the printable page object to the entire document array
        @page_flights.clear # clear the single re-usable page object for the next 33 flights.
        page = 1
      end
    end
    byebug
  end
end
