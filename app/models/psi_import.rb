class PsiImport < ActiveRecord::Base
  
  require 'csv'
  include PsiImportHelper
  
  def self.import(csv_file)
    PsiImport.destroy_all
    CSV.foreach(csv_file.path, :headers => true) do |row|
      PsiImport.create!(row.to_hash)
    end
  end
  
  def self.convert(user)
    @psuedo_entries = PsiImport.select('DISTINCT ON (date,tail) *')
    @psuedo_entries.each do |e|
      @entry = Entry.new()
      # TODO pd start and end set here as the straight imports with them being nil
      # produced 44 hours per diem per day...hacking it for now
      @entry.pd_start = "0001"
      @entry.pd_end = "2359"
      # TODO this 0500 hack has to go away...non imported entries need to be looked at for this too
      @entry.date = DateTime.strptime e.date + ":0500", "%m-%d-%Y:%H%M"
      @entry.tail = e.tail
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
          f.blockout = f.blockout.gsub(":", "")
          f.blockin = f.blockin.gsub(":", "")
          @flight = @entry.flights.new(f.slice(
              :blockout, :blockin, :dep, :arr, :night_ld, :approaches
            ))
          @flight.save
          
          #finally, set the imported flag
          f.imported = true
          f.save
        end
      end
    end
  end
end
