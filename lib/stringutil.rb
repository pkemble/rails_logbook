class String

  CUTOFF = "0400"

  def icao
    if self.length == 3 && self !~ /\d/
      self.prepend("K")
    end
    return self.upcase
  end
  
  def remove_icao
    if self.length == 4 && self.upcase[0] == 'K'
      return self[1..3]
    else
      return self
    end
  end

  def check_for_late_flights
    begin
      @d1 = Time.strptime self, "%H%M"
      @d2 = Time.strptime CUTOFF, "%H%M"

      Rails.logger.debug "Comparing #{@d1} < #{@d2}"
      if @d1 <= @d2
        return true
      else
        return false
      end
    rescue
      Rails.logger.debug "#{self} can't be converted to HHMM"
    end
  end
end

