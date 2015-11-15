class Entry < ActiveRecord::Base
	has_many :flights
	
	validates :date, presence: true
		
	attr_accessor :total_time
	
	before_save do
	  if self.tail =~ /^\d{3}$/
	    self.tail = 'N' + self.tail.upcase + 'AF'
	  end	  
	end
	
	def total_time
	  t = 0
	  self.flights.each do |f|
	    t = t + f.total_time
	  end
	  total_time = t
	end
	
end
