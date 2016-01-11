class Entry < ActiveRecord::Base
	has_many :flights
	
	validates :date, presence: true
		
	attr_accessor :total_time, :arpt_string
	
	before_save do
	  # tail
	  if self.tail =~ /^\d{3}$/
	    self.tail = 'N' + self.tail.upcase + 'AF'
	  end
	  
	  #flight number
	  if self.flight_number =~ /^\d*$/
	    self.flight_number = 'CNS' + self.flight_number
	  end
	  
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
	  a = ""
	  unless self.flights.any? == false
	    self.flights.each do |f|
	     a += f.dep.gsub('K', '') + '/'
  	  end
  	  a += self.flights.last.arr.gsub('K','')
	  end
    arpt_string = a
	end
	
end
