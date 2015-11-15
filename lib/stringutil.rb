class String
  def icao
    if self.length == 3 && self !~ /\d/ then
      self.prepend("K")
    end
    self.upcase
  end
end

