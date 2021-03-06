class EntriesController < ApplicationController
  
  before_action :logged_in_user
  before_action :correct_user
  
  def index
    # in case someone types it in...
    redirect_to root_path
  end
  
  # TODO is this used?
  def show
    byebug
    @entry = Entry.find(params[:id])
    @aircraft = Aircraft.all
  end
  
  def new
    @user = current_user
  	@entry = Entry.new
    @aircraft = Aircraft.all
  end  
  
  def edit
    @entry = Entry.find(params[:id])
    @flights = @entry.flights.order(:p_blockout)
    @entry.get_formatted_per_diem_times
    @aircraft = Aircraft.all
  end
	
  def create
    @entry = Entry.new(entry_params)
    @aircraft = Aircraft.all
    if URI(request.referer).path == "/continued_entry"
      @entry.from_recent_entry = true
    end
    
    @user = current_user
    
    unless @user.nil? 
      @entry.user_id = @user.id
    end
    
    if @entry.save
      if params[:commit] == "Create entry and add flights"
        redirect_to new_entry_flight_path(@entry.id)
      else
        redirect_to edit_entry_path(@entry.id)
      end
    else
      render 'new'
    end
  end
  
  def next_entry
    
    last_entry = Entry.where(user_id: current_user.id).last
    @entry = Entry.new
    @entry.aircraft = last_entry.aircraft
    @entry.pic = last_entry.pic
    @entry.crew_name = last_entry.crew_name
    @entry.flight_number = last_entry.flight_number
    
    render 'new'
    
  end
  
  def update
    @entry = Entry.find(params[:id])
    if @entry.update(entry_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @entry = Entry.find(params[:id])
    if @entry.flights.any?
      @entry.flights.each do |f|
        f.destroy #TODO might provide an undo for this?
      end
    end
    @entry.delete
    redirect_to root_path
  end
    
  private
    def entry_params
      params.require(:entry).permit( :date, :aircraft_id, :pic, :crew_name, :crew_meal,
                                    :tips, :remarks, :flight_number, :pd_start,
                                    :pd_end, :travel_expenses, :commit_type )
    end
      
end
