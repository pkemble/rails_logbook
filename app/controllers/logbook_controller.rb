class LogbookController < ApplicationController
  before_action :logged_in_user
  before_action :current_user
  
  def index
    if logged_in?
      @entries = Entry.where(user_id: current_user.id).order(:date).paginate( page: params[:page], per_page: 10)
    else
      redirect_back_or login_path
    end
  end
end
