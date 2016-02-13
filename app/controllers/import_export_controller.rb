class ImportExportController < ApplicationController
  
  before_action :logged_in_user
  before_action :correct_user
  
  
  def index
    @prev_month = Time.now.prev_month.strftime('%B')
    @past_months = Entry.past_months
  end
  
  def psi_expense
    @user = current_user
    if params[:month].nil? 
      @t = Time.now.prev_month.beginning_of_month
      @e = Time.now.prev_month.end_of_month
      @entries = Entry.where(date: @t..@e, user_id: @user.id ).order(:date)
      #render :text => psi_output TODO
    else
      
    end
      
  end
end