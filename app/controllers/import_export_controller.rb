class ImportExportController < ApplicationController
  def index
    @month = Time.now.prev_month.strftime('%B')
  end
  
  def psi_expense
    @t = Time.now.prev_month.beginning_of_month
    @e = Time.now.prev_month.end_of_month
    @entries = Entry.where(date: @t..@e).order(:date)
    #render :text => psi_output TODO
    
  end
end
