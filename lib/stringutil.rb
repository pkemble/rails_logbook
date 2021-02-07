class String

  def icao
    if self.length == 3 # && self !~ /\d/
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

	def fix_btime
		@str = self.gsub(":", "")
		if @str.length == 1
			return '000' + @str
		elsif @str.length == 2
			return '00' + @str
		elsif @str.length == 3
			return '0' + @str
		else
			return @str
		end
	end
end

