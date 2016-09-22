class Flight < ActiveRecord::Base
  
  require 'hobbstime'
  require 'stringutil'
    
  belongs_to :entry
  
  attr_accessor :last_loc
  
  validates :dep, :arr, :presence => true
  validates :blockout, :blockin, :time_format => true
  #validates :night, :if "night < total_time" # TODO
  
  before_save do
    self.dep = self.dep.icao
    self.arr = self.arr.icao
    unless blockout.nil? || blockin.nil? #TODO test this
      @f_hobbs_time = HobbsTime.new(blockout, blockin, entry.date)
      self.p_blockout = @f_hobbs_time.hobbs_start
      self.p_blockin = @f_hobbs_time.hobbs_end
      self.block_time = @f_hobbs_time.span
    end
  end

  def glob
    GlobLogger.debug "Globbing flight #{id}"
    @orig_entry = Entry.find(entry_id)
    @orig_date = @orig_entry.date
    if @orig_date.nil?
      GlobLogger.debug "Date nil for flight id #{id}"
      return
    end

    @prev_date = @orig_date.yesterday
    @new_entry = Entry.where(date: @prev_date)

    if @new_entry.count == 0 || @new_entry.count > 1
      GlobLogger.debug "Found less than or more than 1 Entry for #{@prev_date}"
      return
    end

    entry_id = @new_entry[0].id
    #if f.save!
    GlobLogger.debug "Moved flight id: #{id} to entry id: #{@new_entry.id}"
    #end
  end
  
  def n_curr #not used
    a = self.night_to ? self.night_to : "0"
    b = self.night_ld ? sefl.night_ld : "0"
    n_curr = a + "/" + b
  end
  
  def totals
    
  end

  def is_xc
    return self.pf
  end
  
  private
  def to_utc(btime)
    DateTime.strptime(btime.to_s, "%H%M").to_time.utc
  end
end