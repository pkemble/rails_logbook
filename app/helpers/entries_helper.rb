module EntriesHelper
  def tail_helper(entry)
    unless entry.tail.length == 3 && entry.tail =~ /\d{3}/
      #TODO - what was I going to do here?
    end 
  end
end
