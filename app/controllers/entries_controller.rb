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
  end
  
  def new
    @user = current_user
  	@entry = Entry.new
  end  
  
  def edit
    @entry = Entry.find(params[:id])
    @flights = @entry.flights.order(:blockout)
    @entry.get_formatted_per_diem_times
  end
	
  def create
    @entry = Entry.new(entry_params)
    @user = current_user
    
    unless @user.nil? 
      @entry.user_id = @user.id
    end
    
    if @entry.save
      byebug
      if params[:commit] == "Create entry and add flights"
        redirect_to new_entry_flight_path(@entry.id)
      else
        redirect_to edit_entry_path(@entry.id)
      end
    else
      render 'new'
    end
  end
  
  def continued_entry
    
    @recent_entry = Entry.where(user_id: current_user.id).last
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
      params.require(:entry).permit( :date, :tail, :pic, :crew_name, :crew_meal,
                                    :tips, :remarks, :flight_number, :pd_start,
                                    :pd_end, :travel_expenses, :commit_type )
    end
    
    def recent_params
      [ tail, pic, crew_name, flight_number ]
    end
      
end
