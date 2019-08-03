class PrintPage
  attr_accessor :flights, :totals, :running_total, :s_flights, :s_totals, :s_running_total
  
  def serialized
#    s_flights = Array.new
#    self.flights.each do |f|
#      s_flights.append FlightSerializer.new(f).as_json 
#    end
    s_flights = self.flights.to_json
    s_totals = self.totals.to_json
    s_running_total = self.running_total.to_json
    return { :page_flights => s_flights, :page_totals => s_totals, :running_total => s_running_total }.to_json
  end
end