class LogbookController < ApplicationController
  def index
    @entries = Entry.order(:date)
        
  end
end
