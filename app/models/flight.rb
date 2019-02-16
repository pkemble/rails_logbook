class Flight < ActiveRecord::Base
  
  require 'hobbstime'
  require 'stringutil'
  require 'sun-times'
  CUTOFF = "04"
    
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
  
  def add_night_time
    if self.night != nil
      return
    end
    
		#get sunrise and sunset for each airport
		@dep = Airport.where(icao: self.dep).where.not(lat: nil).first
		if @dep.nil?
		  Airport.add_missing_airport(self.dep)
		  return
		end
		@arr = Airport.where(icao: self.arr).where.not(lat: nil).first
    if @arr.nil?
      Airport.add_missing_airport(self.arr)
      return
    end
		if @dep.nil? || @arr.nil?
			Rails.logger.debug('Either #{self.dep} or #{self.arr} are not in the airports database')
			return
		end
		unless self.p_blockout.nil? or self.p_blockin.nil?
		
			@day = self.entry.date
			@blockout = self.p_blockout.to_s
			@blockin = self.p_blockin.to_s
			@sun_times_dep = SunTimes.new
			@rise_dep_utc = @sun_times_dep.rise(@day, @dep.lat, @dep.lon)
			@set_dep_utc = @sun_times_dep.set(@day, @dep.lat, @dep.lon)
			
			@sun_times_arr = SunTimes.new
			@rise_arr_utc = @sun_times_arr.rise(@day, @arr.lat, @arr.lon)
			@set_arr_utc = @sun_times_arr.set(@day, @arr.lat, @arr.lon)
			
			if @rise_dep_utc.nil? or @rise_arr_utc.nil? or @set_dep_utc.nil? or @set_arr_utc.nil?
			  logger.debug 'Something was null: #{self.id}'
			  return
			end
			#byebug
			#is sunrise after blockin?
			if @rise_dep_utc > @blockin
			# - yes, entire flight is night
				self.night = self.block_time
			#is sunrise after blockout?
			elsif @rise_dep_utc > @blockout
			# - yes, calculate how much after
				@night_time = @rise_dep_utc - Time.parse(@blockout)
			# - no
			
			#is sunset before blockout?
			elsif @set_dep_utc < @blockout
			# - yes, the entire flight is night
				self.night = self.block_time
			# - no
			
			#is sunset before blockin?
			elsif @set_arr_utc < @blockin
			# - yes, calculate how much afterarr
				@night_time = Time.parse(@blockin) - @set_arr_utc 
			end
			unless @night_time.nil?
        # check flight 351045793. using arrival sunset could create night longer than total block
			  @total_night  = (@night_time / 3600).round(1)
			  self.night = self.block_time < @total_night ? self.block_time : @total_night
			end
			self.save!
			logger.debug 'Logged #{self.night} hours for Flight id: #{self.id}'
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
    @candidate_entries = Entry.where(date: @prev_date)

    if @candidate_entries.count == 0 || @candidate_entries.count > 1
      GlobLogger.debug "Found less than or more than 1 Entry for #{@prev_date}"
      return
    end

    @new_entry = @candidate_entries[0]

    self.entry_id = @new_entry.id
    self.globbed = true

    if self.save!
      GlobLogger.debug "Moved flight id: #{id} to entry id: #{@new_entry.id}"
    end
  end

  def check_for_late_flights
    begin
      @d1 = self.p_blockout
      @d2 = self.p_blockout.change({hour: CUTOFF, min: 0})

      Rails.logger.debug "Comparing #{@d1} < #{@d2}"
      if @d1 <= @d2
        return true
      else
        return false
      end
    rescue
      Rails.logger.debug "#{self} can't be checked. p_blockout nil?"
    end
  end
  
  def n_curr #not used
    a = self.night_to ? self.night_to : "0"
    b = self.night_ld ? sefl.night_ld : "0"
    n_curr = a + "/" + b
  end
  
  def totals
    
  end

  def check_for_xc 
    
    @dep = Airport.where(icao: self.dep).where("lat IS NOT NULL").to_a[0]
    @arr = Airport.where(icao: self.arr).where("lat IS NOT NULL").to_a[0]
    if @dep.nil?
      Airport.add_missing_airport(self.dep.remove_icao)
      return
    end
    if @arr.nil?
      Airport.add_missing_airport(self.arr.remove_icao)
      return
    end
    
    a = Geokit::LatLng.new(@dep.lat, @dep.lon)
    b = Geokit::LatLng.new(@arr.lat, @arr.lon)
    self.distance = a.distance_to(b).round(1)
    
    if self.distance > 50 and self.pf?
      self.xc = true
    else
      self.xc = false
    end
    self.save!
  end
  
  private
  def to_utc(btime)
    DateTime.strptime(btime.to_s, "%H%M").to_time.utc
  end
end