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
      per_page: 100)
    end
  end
end
