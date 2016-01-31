module FlightsHelper
  
  def self.last_loc(user, entry)
    # unless @flight.dep.nil?
      # return @flight.dep
    # end
    if entry.flights.any?
      return entry.flights.last.arr
    else
      @entries = Entry.where(user_id: user.id).order('date')
      if @entries.any?
        @last_entry = Entry.order('date').last(2)[0]
        if @last_entry.flights.any?
          return @last_entry.flights.last.arr
        end
      end
    end
  end
  
end
