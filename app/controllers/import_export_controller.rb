class ImportExportController < ApplicationController
  
  include ImportExportHelper
  
  before_action :logged_in_user
  before_action :correct_user
  
  
  def index
    @prev_month = Time.now.prev_month.strftime('%B')
    @prev_month_num = Time.now.prev_month.strftime('%m')
  end
  
  def upload
    if PsiImport.import(params[:csv_data])
    else
      flash.now[:danger] = "d'oh"
    end
    redirect_to psi_import_path
  end
  
  def import_loaded_csv
      @user = current_user
      PsiImport.convert(@user)
      flash[:success] = "imported all that shit"
      redirect_to psi_import_path
  end
  
  def psi_import
    @psi_imports = PsiImport.all
  end
  
  def psi_expense
    byebug
    @user = current_user
    if params[:month].nil? 
      @t = Time.now.prev_month.beginning_of_month
      @e = Time.now.prev_month.end_of_month
      byebug
      @entries = Entry.where(date: @t..@e, user_id: @user.id ).order(:date)
      #render :text => psi_output TODO
    else
      
    end
      
  end
end
