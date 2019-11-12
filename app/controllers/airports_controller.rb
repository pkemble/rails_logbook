class AirportsController < ApplicationController
  def show
    @airport = Airport.find(params[:id])
  end
  
  def index
    @countries = Airport.select(:country)
    if params[:missing]
      @airports = Airport.where(lat: nil).paginate(page: params[:page], per_page: 30)
    else
      @airports = Airport.all.order('airports.used desc').paginate(page: params[:page], per_page: 30)
    end
  end
  
  def search
    term = params[:term]
    airports = []
    airports = Airport.where('country LIKE ?', "%#{term}%").limit 25 if term
    render json: airports
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
