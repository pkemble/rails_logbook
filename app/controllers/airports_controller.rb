class AirportsController < ApplicationController
  def show
    @airport = Airport.find(params[:id])
  end
  
  def index
  	
  end
  private
    def airport_params
      params.require(:airport).permit(:lat, :lon, :iata, :icao)
    end
end
