class AirportsController < ApplicationController
	
	before_action :force_json, only: :search_apt 
	
  def edit
    @airport = Airport.find(params[:id])
    @flights = Flight.where(dep: @airport).or(Flight.where(arr: @airport)).paginate(page: params[:page],
        per_page: 30)
  end
  
  def index
    @countries = Airport.select(:country)
    if params[:missing]
      @airports = Airport.where(lat: nil).paginate(page: params[:page], per_page: 30)
    else
      @airports = Airport.all.order('airports.used desc').paginate(page: params[:page], per_page: 30)
    end
  end
  
	def search_apt
		q = params[:q].upcase
		@apts = Airport.search_multiple(q)
	end

	def force_json
			request.format =:json
	end
  
  def new
    @airport = Airport.new
  end
  
  def missing_data
    @airports = Airport.where(lat: nil).paginate(page: params[:page], per_page: 30)
  end
  
  def update
    @airport = Airport.find(params[:id])
    @airport.update(airport_params)
  end
  
  private
    def airport_params
      params.require(:airport).permit(:lat, :lon, :iata, :icao, :name, :country, :state, :city, :elevation)
    end
end
