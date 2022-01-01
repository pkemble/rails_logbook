class QolController < ApplicationController
  require 'roo'
  require 'groupdate'
  def index
    @totals = TotalsHelper::Totals.new
    @years = Qol.select(:year).distinct.order(:year)
    @ann_data = {}
    @years.each do |y|
      @ann_data[y.year] = {
        hg: @totals.hours_gone(Qol.where(year: y.year), y.year.to_i),
        dg: @totals.days_gone(Qol.where(year: y.year), y.year.to_i),
        cycle_dur: trip_durations(Qol.where(year: y.year).order(:date))  
    }
    @trip_day = trip_durations(Qol.all.order(:date))
    end
  end
  
  def trip_durations(qols)
    trips = []
    prev_day = Date.new
    current_trip_days = 0
    current_cycle_count = 0
    start_day = DateTime.new
    trip_days = Array.new # days
    qols.each do |q|
      #if it's the first day
      if current_cycle_count == 0
        current_cycle_count = 1
        prev_day = q.date
        next      
      # if it's the next day
      
        elsif (q.date - prev_day).to_i == 1 && !q.legs.end_with?("PSM")
        current_cycle_count += 1
        prev_day = q.date
        next

      else #end of the cycle
        trip_days.append(current_cycle_count)
        current_cycle_count = 0
      end
    end
  return trip_days.uniq.map {|x| [x, trip_days.count(x)] }.sort_by { |k,v| -v }.to_h
  end
  
  def upload
    x = Roo::Spreadsheet.open(params[:file].path)
    
    #iterate the first column to find the first date indicating the first data row:
    x.column(1).each_with_index do |r, index|
      if r.class == Date
        data_row = x.row(index + 1) #rows are numbered from 1 not 0
        #[Fri, 13 Nov 2020, "N539AF", "PSM-BED-PSM-SFM-LOM", nil, nil, nil, nil, nil, nil, nil, 17.2, 36.12, 36.12]
        #check for a duplicate
        
        if Qol.where(date: data_row[0], tail: data_row[1]).count > 0
          next
        end
        
        qol = Qol.new
        qol.date = data_row[0]
        qol.tail = data_row[1]
        qol.legs = data_row[2]
        qol.pd = data_row[10]
        qol.amount = data_row[11]
        qol.total = data_row[12]
        
        #extract date
        qol.month = qol.date.strftime('%B')
        qol.year = qol.date.strftime('%Y')
        qol.save!
        
      end
    end
      
  end
  
  def post_params
    params.require(:qol).permit(:file, :expense_reports [])
  end
end
