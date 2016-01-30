class LogbookController < ApplicationController
  include SessionsHelper
  
  def index
    if logged_in?
      @entries = Entry.where(user_id: current_user.id)
    else
      redirect_back_or login_path
    end
  end
end
