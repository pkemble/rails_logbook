class EntriesController < ApplicationController
  def index
    # in case someone types it in...
    redirect_to root_path
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
    @entry.get_formatted_per_diem_times
  end
	
  def create
    @entry = Entry.new(entry_params)
    if @entry.save
      redirect_to edit_entry_path(@entry.id)
    else
      render 'new'
    end
  end
  
  def update
    @entry = Entry.find(params[:id])
    if @entry.update(entry_params)
      redirect_to root_path
    else
      redirect_to edit_entry_path(@entry.id)
    end
  end
  
  def destroy
    @entry = Entry.find(params[:id])
    @entry.delete
    redirect_to root_path
  end
    
  private
    def entry_params
      params.require(:entry).permit( :date, :tail, :pic, :crew_name, :crew_meal,
                                    :tips, :remarks, :flight_number, :pd_start,
                                    :pd_end, :extract_per_diem )
    end
      
end
