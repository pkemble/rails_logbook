class LogbookController < ApplicationController
  before_action :logged_in_user
  before_action :current_user
  
  def index
    if logged_in?
      @entries = Entry.where(user_id: current_user.id)
    else
      redirect_back_or login_path
    end
  end
end
