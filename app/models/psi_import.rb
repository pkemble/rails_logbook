class PsiImport < ActiveRecord::Base
  
  require 'csv'
  include PsiImportHelper
  
  def self.import_pre_astro(csv_file)
    PsiImport.delete_all

    CSV.foreach(csv_file.path, :headers => true) do |row|

      @crow = PsiImport.new()

      @crow.date = row["Date"]
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
      @crow.save!
    end
  end

  def self.import(csv_file)
    PsiImport.delete_all
    CSV.foreach(csv_file.path, :headers => true) do |row|
      PsiImport.create!(row.to_hash)
    end
  end
  
  def self.convert(user)
    @psuedo_entries = PsiImport.select('DISTINCT ON (date,tail) *') #TODO: this causes problem with flights late into the next zulu day. see Fragrassi 95KH flights
    @psuedo_entries.each do |e|
      
      begin
        @entry = Entry.new()
        # TODO pd start and end set here as the straight imports with them being nil
        # produced 44 hours per diem per day...hacking it for now
        @entry.pd_start = "0001"
        @entry.pd_end = "2359"
        # TODO this 0500 hack has to go away...non imported entries need to be looked at for this too
        # @entry.date = DateTime.strptime e.date + ":0500", "%m/%d/%Y:%H%M"
        if e.date.include? "-"
          @entry.date = DateTime.strptime e.date + ":0500", "%m-%d-%Y:%H%M"
        elsif e.date.include? ":"
          @entry.date = DateTime.strptime e.date + ":0500", "%m/%d/%Y:%H%M"
        else
          @entry.date = DateTime.strptime e.date + ":0500", "%m/%d/%Y:%H%M"
        end


        @entry.tail = e.tail
        @entry.ac_model = e.ac_model
        @entry.from_recent_entry = true
        if e.pic.include? "Kemble"
          @entry.flight_number = "CNS976"
          @entry.pic = true
          @entry.crew_name = PsiImportHelper.format_crew_name(e.sic)
        else
          @entry.pic = false
          @entry.crew_name = PsiImportHelper.format_crew_name(e.pic)
        end
        @entry.user_id = user.id

        @entry.save

        #flights
        
        @flights = PsiImport.where(date: e.date, tail: e.tail)
        if @flights.any?
          @flights.each do |f|
            unless f.blockout.nil?
              f.blockout = f.blockout.gsub(":", "")
              f.blockin = f.blockin.gsub(":", "")
            end
            @flight = @entry.flights.create(f.slice(
                :blockout, :blockin, :dep, :arr, :night_ld, :approaches
              ))

            if @flight.blockout.nil?
              Rails.logger.debug "blockout/blockin missing: using btime in csv"
              @flight.block_time = f.btime
            end

            unless f.night_ld || f.dlnd
              @flight.pf = false
            else
              @flight.pf = true
            end

            @flight.night = f.ntime

            @flight.user_id = user.id
            @flight.save

            #finally, set the imported flag
            f.imported = true
            f.save
          end
        end
      
      rescue => oops
        Rails.logger.debug "oops...PsiImport.find(#{e.id}): #{oops}"
        next
      end
    end
  end
end
