class UsersController < ApplicationController
  include UsersHelper
  
  before_action :logged_in_user, :except => [:new, :create]
  before_action :correct_user, :except => [:new, :create]
  
	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end
	
	def create
	  @user = User.new(user_params)
    if @user.save(user_params)
      log_in @user
      flash[:success] = "welcome"
      redirect_to root_path
    else
      render 'new'
    end
	end
	
	def edit
	  @user = User.find(params[:id])
	end
	
	def update
	  @user = User.find(params[:id])
	  if @user.update_attributes(user_params)
	    flash[:success] = "Updated settings"
	    redirect_to root_path
	  else
	    render 'edit'
	  end
	end
	
	private
	 def user_params
	   params.require(:user).permit(:name, :email, :password, :password_confirmation, :def_tail_number, :def_flight_number)
	 end
	 
	 # before filters
	 

end
