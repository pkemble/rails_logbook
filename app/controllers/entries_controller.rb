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
  
  def continued_entry
    
    @recent_entry = Entry.last
    @entry = Entry.new
    @entry.tail = @recent_entry.tail
    @entry.pic = @recent_entry.pic
    @entry.crew_name = @recent_entry.crew_name
    @entry.flight_number = @recent_entry.flight_number
    
    render 'new'
    
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
                                    :pd_end )
    end
    
    def recent_params
      [ tail, pic, crew_name, flight_number ]
    end
      
end
