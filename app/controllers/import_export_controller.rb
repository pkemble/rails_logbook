class ImportExportController < ApplicationController
  def index
    @entries = Entry.all
  end
end
