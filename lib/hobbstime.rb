#Times Util

class HobbsTime
  
  attr_reader :hobbs_start, :hobbs_end, :hobbs_date, :span
  
  HMFormat = "%H%M"
  
  def initialize(t1=nil, t2=nil, date=nil) # TODO make date arg required.
    if date == nil
      return nil
    end
    
    @hobbs_start = t1.nil? || t1.empty? ? date.beginning_of_day : date.change(hour: t1[0..1], min: t1[2..3])
    @hobbs_end = t2.nil? || t2.empty? ? date.tomorrow : date.change(hour: t2[0..1], min: t2[2..3])
    @hobbs_date = date
    @span = span
  end

  def span
    # if @hobbs_start.nil? && @hobbs_end.nil?
      # return 24
    # end
        
    if @hobbs_end < @hobbs_start
      @hobbs_start = @hobbs_start.prev_day
    end
    
    return ((@hobbs_end - @hobbs_start) / 3600 ).round(1)
  end
  
  # gets a time object and returns the HMFormat constant format 
  def self.to_short_format(t)
    return t.localtime.strftime(HMFormat) #TODO revisit timezones
  end
end