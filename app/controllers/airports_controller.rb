class AirportsController < ApplicationController
  def show
    @airport = Airport.find(params[:id])
  end
end
