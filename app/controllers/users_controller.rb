class UsersController < ApplicationController
  include UsersHelper
  
  before_action :logged_in_user, :except => [:new, :create]
  before_action :correct_user, :except => [:new, :create]
  
  def admin
    if current_user.admin?
      @users = User.all
    else
      flash[:danger] = "You must be an admin to be there!"
      redirect_to root_path
    end
  end
  
	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end
	
	def create
	  @user = User.new(user_params)
    if @user.save
      log_in @user
      #TODO help pages:
      flash[:partial] = "welcome_message"
      redirect_to edit_user_path(@user)
    else
      render 'new'
    end
	end
	
	def edit
	  @user = User.find(params[:id])
	end
	
	def update
	  @user = User.find(params[:id])
	  if @user.update(user_params)
	    flash[:success] = "Updated settings"
	    redirect_to root_path
	  else
	    render 'edit'
	  end
	end
	
	def destroy
	  @user = User.find(params[:id]).destroy
	  flash[:success] = "#{@user.name} deleted"
	  redirect_to admin_path
	end
	
	private
	 def user_params
	   params.require(:user).permit(:name, :email, :password, :password_confirmation, :def_tail_number, :def_flight_number)
	 end
	 
	 # before filters
	 

end
