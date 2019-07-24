class LogbookController < ApplicationController
  before_action :logged_in_user
  before_action :current_user
  
  require 'totals'
  
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
    @running_total = PageTotals.new()
    @flights.each do |f|
      @page_flights = Array.new
      @page_flights.append f
      page += 1
      if page == 33 #make this a setting
        @page_total = PageTotals.new()
        @page_total.get_page_totals(@page_flights)
        @running_total.add_to_running_total(@page_total)
      end
    end
    
    
  end
end
