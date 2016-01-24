class Entry < ActiveRecord::Base
  require 'hobbstime'
  
	has_many :flights
		
	validates :date, presence: true
	validates :pd_end, :pd_start, :time_format => true
		
	attr_accessor :total_time, :arpt_string, :pd_start, :pd_end, :extract_per_diem
	
	before_save do
	  # tail
	  if self.tail =~ /^\d{3}$/
	    self.tail = 'N' + self.tail.upcase + 'AF'
	  end
	  
	  #flight number
	  if self.flight_number =~ /^\d*$/
	    self.flight_number = 'CNS' + self.flight_number
	  end
	  
	  #per diem
	  #TODO extract per diem
	  @per_diem = HobbsTime.new(pd_start, pd_end, self.date)
	  self.per_diem_hours = @per_diem.span
	  self.per_diem_start = @per_diem.hobbs_start
	  self.per_diem_end = @per_diem.hobbs_end

	  self.total_time = total_time
	  
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
	  arpt_string = ""
	  unless self.flights.any? == false
	    self.flights.each do |f|
	     arpt_string += f.dep.gsub('K', '') + '-'
  	  end
  	  arpt_string += self.flights.last.arr.gsub('K','')
	  end
	end
	
	def get_formatted_per_diem_times
    unless self.per_diem_start.nil? || self.per_diem_end.nil?
      self.pd_start = HobbsTime.to_short_format(self.per_diem_start)
      self.pd_end = HobbsTime.to_short_format(self.per_diem_end)
    end
  end
end
