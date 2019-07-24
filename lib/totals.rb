class PageTotals
    attr_accessor :block_time, :sepic, :sesic, :mepic, :mesic, :setb, :metb, :instrument, :night, :appr
    
    def initialize
      self.night = 0
      self.appr = 0
      self.instrument = 0
      self.metb = 0
      self.setb = 0
      self.mesic = 0
      self.mepic = 0
      self.sesic = 0
      self.sepic = 0
      self.block_time = 0
    end
    
    def get_page_totals(flights)
      flights.each do |f|
        self.night += f.night unless f.night.blank?
        self.appr += f.approaches unless f.approaches.blank?
        self.instrument += f.instrument unless f.instrument.blank?
        if f.entry.ac_model.start_with? 'BE400' or 'PA44' and f.entry.pic
          self.mepic += f.block_time
        end
        if f.entry.ac_model.start_with? 'BE400'
          self.metb += f.block_time 
        end
        if f.entry.ac_model.start_with? 'PC12'
          self.setb += f.block_time
        end
        if f.entry.ac_model.start_with? 'BE400' and f.entry.pic == FALSE
          self.mesic += f.block_time
        end
        if f.entry.ac_model.start_with? 'PC12' and f.entry.pic == FALSE
          self.sesic += f.block_time
        end
        if f.entry.pic and f.entry.ac_model.start_with? 'BE400' or 'PA44' == FALSE
          self.sepic += f.block_time
        end
      end
    end
    
    def add_to_running_total(page_total)
      self.night += page_total.night
      self.instrument += page_total.instrument
      self.appr += page_total.appr
      self.mepic += page_total.mepic
      self.mesic += page_total.mesic
      self.sepic += page_total.sepic
      self.sesic += page_total.sesic
      return page_total
    end
end

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