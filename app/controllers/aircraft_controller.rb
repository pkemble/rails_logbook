class AircraftController < ApplicationController
  def create
    @aircraft = Aircraft.find(params[:id])
    if @aircraft.save
      redirect_to edit_aircraft_path
    end
  end

  def edit
    @aircraft = Aircraft.find(params[:id])
  end
  
  def update
    @aircraft = Aircraft.find(params[:id])
    if !@aircraft.update(aircraft_params)
      render 'edit'
    end
  end
  
  private
    def aircraft_params
      params.require(:aircraft).permit(:id, :tail, :ac_model, :efis, :fadec, :glass, :multi, :turbine) 
    end
end
