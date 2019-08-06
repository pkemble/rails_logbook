class Entry < ActiveRecord::Base
  require 'hobbstime'
  require 'stringutil'
  
  include ActiveModel::Dirty
  include ActiveModel::Validations
  include EntriesHelper
  
	has_many :flights
	
	belongs_to :user
	belongs_to :aircraft
		
	validates :date, :presence => true
	validates :pd_end, :pd_start, :time_format => true
  validates_uniqueness_of :date, scope: [:date, :tail], 
  :message => Proc.new {|entry| "Entry exists with #{entry.date.strftime('%m/%d/%Y')} on #{entry.tail}"}
		
	attr_accessor :total_time, :arpt_string, :pd_start, :pd_end,
	 :per_diem_hours_formatted, :user_has_entries, :from_recent_entry
	
	before_save do

	  #flight number
	  unless @user.nil? || @user.def_flight_number.nil? || 
	    !self.flight_number_changed? || self.from_recent_entry
	    
	    self.flight_number = @user.def_flight_number.gsub('*', self.flight_number)
	  end
	  
	  #per diem
	  #TODO extract per diem
	  @per_diem = HobbsTime.new(pd_start, pd_end, self.date)
	  self.per_diem_hours = @per_diem.span
	  self.per_diem_start = @per_diem.hobbs_start
	  self.per_diem_end = @per_diem.hobbs_end

	  #self.flight_time = flight_time
	  
	  #clean up crew meals
	  if self.crew_meal == 0
	    self.crew_meal = nil
	  end
	  
	end
	
	def nice_date
	  self.date.strftime("%m/%d/%Y")
	end
	
	def flight_time
	  t = 0
	  if self.flights.any?
	   self.flights.each do |f|
	     unless f.block_time.nil?
         t += f.block_time
	     end
	   end  
	  end
	  flight_time = t.round(1)
	end

  def xc #TODO this is currently more like pf time - no distance measurements made
    t = 0
    if self.flights.any?
      self.flights.each do |f|
        if f.pf and f.block_time.nil?
          t += f.block_time
        end
      end
    end
    xc = t.round(1)
  end
	
	def arpt_string
	  a = ""
	  unless self.flights.any? == false
	    self.flights.order(:id).each do |f|
	     a += f.dep.remove_icao + '-'
  	  end
  	  a += self.flights.order(:id).last.arr.remove_icao
	  end
    arpt_string = a
	end
	
	def get_formatted_per_diem_times
    unless self.per_diem_start.nil? || self.per_diem_end.nil?
      self.pd_start = HobbsTime.to_short_format(self.per_diem_start)
      self.pd_end = HobbsTime.to_short_format(self.per_diem_end)
    end
  end
  
  def user_has_entries?
    Entry.where(user_id current_user.id).any?
  end
  
  private
  
#  def not_duplicate
#    @duplicates = Entry.where(date: self.date).where(tail: self.tail).select('*')
#    if @duplicates.count > 0
#      @map = @duplicates.map {|row| row[:id]}
#      @duplicate_list = ''
#      @map.each do |d|
#        @duplicate_list << "\n" + d.to_s
#      end
#      errors.add(:base, "Duplicate found: " + @duplicate_list)
#      return false
#    end
#    return true
#  end
end
  
