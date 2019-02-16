class Totals
  attr_reader :time, :pic, :sic, :instrument, :night
  
  #paper logbook constants don't include any sic, or turbine
  P_TOTAL_TIME = 1290.7
  P_TOTAL_MULTI = 83.7
  P_TOTAL_PIC = 1213.4
  P_TOTAL_INSTRUMENT = 38.8
  P_TOTAL_NIGHT = 219.2
  P_TOTAL_XC = 323.4
  
  def initialize
#    self.total_pic = total_pic
#    self.total_sic = total_sic
#    self.total_time = total_time
  end
  
  def past_months
  end
   
  def time
    return (Flight.sum(:block_time) + P_TOTAL_TIME).round(1)
  end
  
  def pic
    return get_totals true
  end

  def sic
    return get_totals false
  end
  
  def multi
    @entries = Entry.where("ac_model like 'BE400%' or ac_model like 'PA44%'")
    return total_hopper(@entries) + P_TOTAL_MULTI
  end
  
  def jet
    @entries = Entry.where("ac_model like 'BE400%'")
    return total_hopper(@entries)
  end
  
  def turbine_pic
    t = 0
    @entries = Entry.where("ac_model like 'PC12%' and pic is true") #TODO I guess add in any other a/c where I was pic turbine in the future
    @entries.each do |e|
      t += e.flight_time
    end
    return t.round(1)
  end
  
  def multi_turbine_sic
    t = 0
    @entries = Entry.where("ac_model like 'BE400%' and sic is true") #TODO I guess add in any other a/c where I was sic turbine in the future
    return total_hopper(@entries)
  end
  
  def turbine
    @entries = Entry.where("ac_model like 'BE400%' or ac_model like 'PC12%'")
    return total_hopper(@entries)
  end
  
  def instrument
    return Flight.sum(:instrument).round(1) + P_TOTAL_INSTRUMENT
  end
  
  def night
    return Flight.sum(:night).round(1) + P_TOTAL_NIGHT
  end
  
  def xc
    return Flight.where(xc: :true).sum(:block_time).round(1) + P_TOTAL_XC
  end
  
  private
  def get_totals (pic)
    t = pic ? P_TOTAL_PIC : 0
    @entries = Entry.where(pic: pic)
    return total_hopper(@entries) + t
  end
  
  def total_hopper(entries)
    t = 0
    entries.each do |e|
      t += e.flight_time
    end
    return t.round(1)
  end
end