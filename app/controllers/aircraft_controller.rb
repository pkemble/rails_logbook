class AircraftController < ApplicationController
  def index
    @aircrafts = Aircraft.all.order(ac_model: :asc).order(tail: :asc).where(user_id: current_user).sort_by {|ac| ac.entry_num }.reverse
  end
  
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
      render 'index'
    else
      redirect_to aircraft_index_path, notice: @aircraft.tail + " saved successfully."
    end
  end
  
  private
    def aircraft_params
      params.require(:aircraft).permit(:id, :tail, :ac_model, :efis, :fadec, :glass, :multi, :turb, :turboprop) 
    end
end
