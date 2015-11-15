module EntriesHelper
  def tail_helper(entry)
    unless entry.tail.length == 3 && entry.tail =~ /\d{3}/

    end 
  end
end
