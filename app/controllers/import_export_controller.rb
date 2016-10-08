class ImportExportController < ApplicationController
  
  include ImportExportHelper
  
  before_action :logged_in_user, except: [:export]
  before_action :correct_user , except: [:export]
  
  
  def index
    @prev_month = Time.now.prev_month.strftime('%B')
    @prev_month_num = Time.now.prev_month.strftime('%m')
  end
  
  def export
    @since = params[:since]
    @user_id = User.find_by(email: params[:email]).id
    @dSince = Time.strptime(@since, "%s")
    @entries = Entry.where(user_id: @user_id).where("updated_at > ?", @dSince).order(:date)
    render :json => @entries.to_json(:include => :flights)
  end
  
  def upload
    unless PsiImport.import(params[:csv_data])
      flash.now[:danger] = "d'oh"
    end
    redirect_to psi_import_path
  end
 
  def upload_pre_astro
    unless PsiImport.import_pre_astro(params[:csv_data])
      flash.now[:danger] ="wtf"
    end
    redirect_to psi_import_path
  end

  def import_loaded_csv
    @user = current_user
    PsiImport.convert(@user)
    flash[:success] = "imported all that shit"
    redirect_to psi_import_path
  end

  def reimport_psi_imports
    @user = current_user

    Flight.delete_all(user_id: @user.id)
    Entry.delete_all(user_id: @user.id)

    PsiImport.convert(@user)

    flash[:success] = "reimported all that shit"
    redirect_to psi_import_path
  end
  
  def psi_import
    @psi_imports = PsiImport.all
  end

  def glob_flights
    @user = current_user
    GlobLogger.debug "\n #{Time.now}\n"
    GlobLogger.debug "=========================================="
    GlobLogger.debug "Globbing flights for #{@user.name}"

    @user_entries = Entry.where(user_id: @user.id)
    @user_entries.each do |e|
      if e.flights.count > 1
        @f1 = e.flights[0]
        @f2 = e.flights[1]
        if @f1.globbed == false && @f1.check_for_late_flights == true
          @blockin = DateTime.strptime(@f1.blockin, "%H%M")
          @next_blockout = DateTime.strptime(@f2.blockout, "%H%M")
          if (@blockin + 10.hours) < @next_blockout
            @f1.glob
          end
        end
      end

    end
    GlobLogger.debug "=========================================="
    redirect_to psi_import_path
  end
  
  def psi_expense
    @user = current_user
    if params[:month].nil? 
      @t = Time.now.prev_month.beginning_of_month
      @e = Time.now.prev_month.end_of_month
      @entries = Entry.where(date: @t..@e, user_id: @user.id ).order(:date)
      #render :text => psi_output TODO
    else
      
    end
      
  end
end
