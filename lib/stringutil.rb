class String
  def icao
    if self.length == 3 && self !~ /\d/
      self.prepend("K")
    end
    return self.upcase
  end
  
  def remove_icao
    byebug
    if self.length == 4 && self.upcase[0] == 'K'
      s = self[1..3]
      return s
    end
  end
end

