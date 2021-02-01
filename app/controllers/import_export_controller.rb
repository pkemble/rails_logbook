class ImportExportController < ApplicationController
  
  include ImportExportHelper
  
  before_action :logged_in_user, except: [:export]
  before_action :correct_user , except: [:export]
  
  def index
    @prev_month = Time.now.prev_month.strftime('%B')
    @prev_month_num = Time.now.prev_month.strftime('%m')
  end
  
  def psi_output
    @t = Time.now.prev_month.beginning_of_month
    @e = Time.now.prev_month.end_of_month
    @entries = Entry.where(date: @t..@e).order(:date)
            # <!-- using Expense report 1/2016 -->
        # <td><%= e.date.strftime("%m/%d/%Y") %></td>
        # <td><%= e.tail %></td>
        # <td><%= e.arpt_string %></td>
        # <td></td><!-- hidden column -->
        # <td></td><!-- catering -->
        # <td></td><!-- travel exp. -->
        # <td><%= e.tips %></td>
        # <td></td><!-- other exp. -->
        # <td><%= e.remarks %></td>
        # <td><%= e.crew_meal %></td>
        # <td><%= e.per_diem_hours %></td>
    @entries.each do |e|
      psi_output = e.datestrftime("%m/%d/%Y")
      psi_output += e.tail
    end
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
  
  def import_airports
  	Airport.import(params[:csv_data])
  	flash[:success] = "Airports Imported"
  	redirect_to psi_import_path
  end

  def import_loaded_csv
    @user = current_user
    PsiImport.convert(@user)
    @import_errors = PsiImport.where(imported: false)
    byebug
    if @import_errors.any?
      @full_errors = '<ul>'
      @import_errors.each do |e|
        @full_errors += '<li>' + e.date.to_s + ' : ' + e.tail + ' : ' + e.import_errors + '</li>'
      end
      @full_errors += '</ul>'
      flash[:warning] = @full_errors.html_safe
    end
    flash[:success] = "Import Complete"
    redirect_to psi_import_path(@import_errors)
  end

  def delete_psi_imports
    PsiImport.delete_all
    flash[:success] = "Imports table cleared."
    redirect_to psi_import_path
  end
  
  def wipe_all
    @user = current_user
	  Flight.delete_all(user_id: @user.id)
    Entry.delete_all(user_id: @user.id)
    PsiImport.delete_all
    flash[:success] = "Flights, Entries, Imports wiped."
    redirect_to psi_import_path
  end
  
  def psi_import
    @psi_imports = PsiImport.order('date').all
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
