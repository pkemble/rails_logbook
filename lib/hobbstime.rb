#Times Util

class HobbsTime
  
  attr_reader :hobbs_start, :hobbs_end, :hobbs_date, :span, :formatted_span
  
  HMFormat = "%H%M"
  
  def initialize(t1=nil, t2=nil, date=Date.today) # TODO make date arg required.
    @hobbs_start = t1.nil? || t1.empty? ? date.beginning_of_day : Time.strptime(t1, HMFormat)
    @hobbs_end = t2.nil? || t2.empty? ? date.tomorrow : Time.strptime(t2, HMFormat)
    @hobbs_date = date
    @span = span
    @formatted_span = formatted_span
  end

  def span        
    if @hobbs_end < @hobbs_start
      @hobbs_start = @hobbs_start.prev_day
    end
    if @hobbs_end == @hobbs_start
      @hobbs_end = @hobbs_end.tomorrow
    end
    
    ((@hobbs_end - @hobbs_start) / 3600 ).round(1)
  end
  
  #returns a formatted span - pretty much removes .0 from 24.0
  def formatted_span
    if self.span.to_s == "24.0"
      return "24"
    else
      return self.span.to_s
    end
  end
  
  # gets a time object and returns the HMFormat constant format 
  def self.to_short_format(t)
    return t.localtime.strftime(HMFormat) #TODO revisit timezones
  end
end