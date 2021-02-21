class PsiImport < ActiveRecord::Base
  
 # 2.4.0 :003 > PsiImport.column_names
 # => ["id", "date", "dep", "arr", "tail", "dto", "nto", "dlnd", "night_ld", "btime", "ntime", "pictime",
 # "sictime", "melpic", "melsic", "holds", "pic", "sic", "created_at", "updated_at", "blockout", "blockin",
 #  "approaches", "imported", "ac_model"]  
  
  require 'csv'
  include PsiImportHelper
  include EntriesHelper
  
  def self.import(csv_file)
    PsiImport.delete_all
    CSV.foreach(csv_file.path, :headers => true) do |row|
    	@crow = PsiImport.new()
    	
    	@crow.date = DateTime.strptime(row["DepartureTimeLocal"], '%m/%d/%Y')
    	@crow.dep = row["OriginAirport"]
    	@crow.arr = row["DestinationAirport"]
    	@crow.ac_model = row["AircraftType"]
    	@crow.tail = row["AircraftRegistration"]
    	@crow.dto = row["DayTakeoffs"]
    	@crow.nto = row["NightTakeoffs"]
    	@crow.dlnd = row["DayLandings"]
    	@crow.night_ld = row["NightLandings"]
    	@crow.btime = row["BlockTimefromFlight"]
      @crow.ntime = row["NightTime"]
    	if row["PIC"].include? "Kemble"
        @crow.pictime = row["PicTime"]
        @crow.melpic = row["MELPicTime"]
      else
        @crow.sictime = row["SicTime"]
        @crow.melsic = row["MELSicTime"]
      end
      @crow.pic = row["PIC"]
      @crow.sic = row["SIC"]
      @crow.holds = row["HoldTime"]
      if row["PrecApproaches"].nil?
      	row["PrecApproaches"] = 0
      end
      if row["Approaches"].nil?
        row["Approaches"] = 0
      end
     	@approaches = row["PrecApproaches"].to_i + row["Approaches"].to_i
      @crow.approaches = @approaches
      unless row["dual_given"].nil?
        @crow.dual_given = row["dual_given"]
        @crow.dual_recvd = row["dual_recvd"]
      end
      @crow.blockout = row["blockout"]
      @crow.blockin = row["blockin"]
      @crow.save!
    end
  end
  
  def self.import_pre_astro(csv_file)
    #PsiImport.delete_all

    CSV.foreach(csv_file.path, :headers => true) do |row|

      @crow = PsiImport.new()

      @crow.date = DateTime.strptime(row["Date"], '%m-%d-%Y')
      @crow.dep = row["Dept"]
      @crow.arr = row["Arr"]
      @crow.tail = row["Tail "]
      @crow.dto = row["Day Landings"] #TODO anything can be done here?
      @crow.nto = row["Night Landings"] #TODO anything can be done here?
      @crow.dlnd = row["Day Landings"]
      @crow.night_ld = row["Night Landings"]
      @crow.btime = row["Block Time"]
      if row["PIC"].include? "Kemble"
        @crow.pictime = row["Block Time"]
      else
        @crow.sictime = row["Block Time"]
      end
      @crow.holds = row["Holds"]
      @crow.pic = row["PIC"]
      @crow.sic = row["SIC"]
      @crow.blockout = row["Dept Time"]
      @crow.blockin = row["Arr Time"]
      @crow.approaches = row["Approaches"]
      @crow.ac_model = 'PC12' #TODO do something smart with tail numbers to differentiate between legacy and NG
      @crow.save!
    end
  end
  
  def self.convert(user)
    PsiImport.all.each do |i|
      begin
        byebug
      	# grab a possibly existing entry if there were errors importing before
      	existing_entries = Entry.joins(:aircraft).where(aircraft: { tail: i.tail }).where(date: i.date)

      	if existing_entries.count == 0
      	  entry = Entry.new()
        	
          # TODO pd start and end set here as the straight imports with them being nil
          # produced 44 hours per diem per day...hacking it for now
          entry.pd_start = "0001"
          entry.pd_end = "2359"
          # TODO this 0500 hack has to go away...non imported entries need to be looked at for this too
          # entry.date = DateTime.strptime e.date + ":0500", "%m/%d/%Y:%H%M"
          #if e.date.include? "-"
  #          entry.date = DateTime.strptime(e.date, "%m-%d-%Y")
  #        elsif e.date.include? ":"
  #          entry.date = DateTime.strptime(e.date, "%m/%d/%Y")
  #        else
  #          entry.date = DateTime.strptime(e.date, "%m/%d/%Y")
  #        end
  			
  			  entry.date = i.date
          #TODO notify so that TAA columns can be added after import to new aircraft 
          
  			  ac = Aircraft.where(tail: i.tail)
  			  if(ac.count == 0)
  			    new_ac = Aircraft.new( :tail => i.tail, :ac_model => i.ac_model, :user_id => user.id )
  			    new_ac.save!
  			    entry.aircraft = new_ac
  			  else
  			    entry.aircraft = ac.first
  			  end
  
          entry.from_recent_entry = true #TODO what was the point of this?
          if i.pic.include? "Kemble" #TODO fix all this so its not hardcoded
            if i.ac_model.start_with?("PC12") && i.sic != nil
              entry.flight_number = "CNS976" #TODO user default flight number
  #          else
  #            entry.flight_number = 'CNS' + i.pic.gsub(/[^\d]/,'')
            end
            entry.pic = true
            entry.crew_name = i.sic.nil? ? '' : PsiImportHelper.format_crew_name(i.sic)
          else
            entry.pic = false
            entry.flight_number = 'CNS' + i.pic.gsub(/[^\d]/,'')
            entry.crew_name = i.pic.nil? ? '' : PsiImportHelper.format_crew_name(i.pic)
          end
          entry.user_id = user.id
          entry.save!
          if entry.errors.any?
            Rails.logger.info entry.errors.messages
            failed_imports = PsiImport.where(date: i.date, tail: i.tail)
            failed_imports.each do |fail|
              fail.import_errors = entry.errors.messages.flatten.pretty_inspect()
              fail.save
            end  
            next
          end
        else
          entry = existing_entries.first
        end
        
        #flights
          
        unless i.blockout.nil?
          i.blockout = i.blockout.fix_btime
          i.blockin = i.blockin.fix_btime
        end
				# Airports
				
				dep = Airport.search(i.dep, true)
				arr = Airport.search(i.arr, true)
				
				#TODO check for a duplicate flights here. not sure if this is possible. without block times in the import,
				# repeated flights to the same airports on the same day with the same crew would show as an existing flight.
				# leaving this for now.
				flight = Flight.new
				flight.blockout = i.blockout
				flight.blockin = i.blockin
				flight.approaches = i.approaches
				flight.night_to = i.nto
				flight.dep = dep
				flight.arr = arr
				flight.entry = entry

        if flight.blockout.nil?
          Rails.logger.debug "blockout/blockin missing: using btime in csv"
          flight.block_time = i.btime
        end
        
        if (i.night_ld == 0 || i.night_ld.nil?) && (i.dlnd == 0 || i.dlnd.nil?)
          flight.pf = false
        else
          flight.pf = true
        end
        
        flight.night_ld = i.night_ld
        flight.day_ld = i.dlnd
        unless i.ntime.nil?
          flight.night = i.ntime
        end

        flight.user_id = user.id
        
        flight.dual_given = i.dual_given
        flight.dual_recvd = i.dual_recvd
        flight.save!
        if flight.errors.any?
          byebug
          Rails.logger.info flight.errors.messages
          i.import_errors = flight.errors.messages.flatten.inspect
          i.save!
          next
        end
        

        #finally, set the imported flag
        i.imported = true
        i.save!
      
      rescue => oops
        i.import_errors = oops.message
        i.save! #TODO these are never getting saved as they don't have ID's - they are a distinct query not a record collection.
        Rails.logger.debug "import error: #{i.id}: #{oops}"
        Rails.logger.debug oops.backtrace[0]
        next
      end
      PsiImport.where(imported: true).delete_all
    end
  end
end