class String
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
end

