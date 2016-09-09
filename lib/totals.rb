class Totals
  attr_reader :time, :pic, :sic, :instrument, :night
  
  def initialize
#    self.total_pic = total_pic
#    self.total_sic = total_sic
#    self.total_time = total_time
  end
  
  def past_months
  end
   
  def time
    return Flight.sum(:block_time)
  end
  
  def pic
    return get_totals true
  end

  def sic
    return get_totals false
  end
  
  def instrument
    return Flight.sum(:instrument)
  end
  
  def night
    return Flight.sum(:night)
  end
  
  private
  def get_totals (pic)
    t = 0
    @entries = Entry.where(pic: pic)
    @entries.each do |e|
      t += e.flight_time
    end
    return t.round(1)
  end
end