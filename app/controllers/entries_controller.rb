class EntriesController < ApplicationController
  def index
  end
  
  def show
    @entry = Entry.find(params[:id])
  end
  
  def new
  	@entry = Entry.new
  end  
  
  def edit
    @entry = Entry.find(params[:id])
    @flights = @entry.flights
  end
	
  def create
    @entry = Entry.new(entry_params)
    @entry.save
    redirect_to edit_entry_path(@entry.id)
  end
  
  def update
    @entry = Entry.find(params[:id])
    @entry.update(entry_params)
    redirect_to root_path
  end
  
  def destroy
    @entry = Entry.find(params[:id])
    @entry.delete
    redirect_to root_path
  end
    
  private
    def entry_params
      params.require(:entry).permit(:date, :tail, :pic, :crew_name, :crew_meal, :tips, :remarks, :flight_number)
    end
      
end
