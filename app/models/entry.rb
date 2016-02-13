class Entry < ActiveRecord::Base
  require 'hobbstime'
  require 'stringutil'
  
  include ActiveModel::Dirty
  
	has_many :flights
	
	belongs_to :user
		
	validates :date, :presence => true
	validates :pd_end, :pd_start, :time_format => true
		
	attr_accessor :total_time, :arpt_string, :pd_start, :pd_end, :per_diem_hours_formatted, :user_has_entries
	
	before_save do
	  
	  # tail
	  @user = User.find(self.user_id)
	  unless @user.nil? || @user.def_tail_number.nil? || 
	    !self.tail_changed? || self.tail.empty?
	    
	    self.tail = @user.def_tail_number.gsub('*', self.tail.upcase)
	  end
	  
	  #flight number
	  unless @user.nil? || @user.def_flight_number.nil? || 
	    !self.flight_number_changed? || self.flight_number.empty?
	    
	    self.flight_number = @user.def_flight_number.gsub('*', self.flight_number)
	  end
	  
	  #per diem
	  #TODO extract per diem
	  @per_diem = HobbsTime.new(pd_start, pd_end, self.date)
	  self.per_diem_hours = @per_diem.span
	  self.per_diem_start = @per_diem.hobbs_start
	  self.per_diem_end = @per_diem.hobbs_end

	  self.total_time = total_time
	  
	  #clean up crew meals
	  if self.crew_meal == 0
	    self.crew_meal = nil
	  end
	  
	end
	
	def nice_date
	  self.date.strftime("%m/%d/%Y")
	end
	
	def total_time
	  t = 0
	  if self.flights.any?
	   self.flights.each do |f|
	     t = t + f.total_time
	   end  
	  end
	  total_time = t
	end
	
	def arpt_string
	  a = ""
	  unless self.flights.any? == false
	    self.flights.each do |f|
	     a += f.dep.remove_icao + '/'
  	  end
  	  a += self.flights.last.arr.remove_icao
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
end
