class ToolsController < ApplicationController
  def night_report
    @output = Flight.all.select(:dep)
    render 'index'
  end
  
  def add_night
    @flights = Flight.all
  	@flights.each do |f|
  		f.add_night_time
  	end
  end
end
