module Totals
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
        flights.each do |flight|
          self.night += flight.night unless flight.night.blank?
          self.appr += flight.approaches unless flight.approaches.blank?
          self.instrument += flight.instrument unless flight.instrument.blank?
          if flight.entry.aircraft.multi and ( flight.entry.pic )
            self.mepic += flight.block_time.round(1)
          end
          if flight.entry.aircraft.multi and ( flight.entry.aircraft.turb || flight.entry.aircraft.turboprop )
            self.metb += flight.block_time.round(1)
          end
          if !flight.entry.aircraft.multi and ( flight.entry.aircraft.turb || flight.entry.aircraft.turboprop )
            self.setb += flight.block_time.round(1)
          end
          
          if flight.entry.aircraft.multi and flight.entry.pic == FALSE
            self.mesic += flight.block_time.round(1)
          end
          if !flight.entry.aircraft.multi and flight.entry.pic == FALSE
            byebug if flight.id == 2889
            self.sesic += flight.block_time.round(1)
          end
          if flight.entry.pic and !flight.entry.aircraft.multi
            self.sepic += flight.block_time.round(1)
          end
          Rails.logger.debug flight.block_time.round(1).to_s + " was added resulting in  " + self.sesic.to_s + " from flight id: " + flight.id.to_s
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
        self.setb += page_total.setb
        self.metb += page_total.metb
        return self
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
      @multi_ac = Aircraft.where(multi: true)
      @entries = Entry.where(aircraft: @multi_ac)
      return total_hopper(@entries) + P_TOTAL_MULTI
    end
    
    def jet
      @turb_ac = Aircraft.where(turb: true)
      @entries = Entry.where(aircraft: @turb_ac)
      return total_hopper(@entries)
    end
    
    def turbine_pic
      t = 0
      @turb_ac = Aircraft.where(turb: true).or(Aircraft.where(turboprop: true))
      @entries = Entry.where(aircraft: @turb_ac).where(pic: true)
      @entries.each do |e|
        t += e.flight_time
      end
      return t.round(1)
    end
    
    def multi_turbine_sic
      t = 0
      @multi_turb = Aircraft.where(turb: true)
      @entries = Entry.where(aircraft: @multi_turb).where(sic: true)
      return total_hopper(@entries)
    end
    
    def turbine
      @turb = Aircraft.where(turb: true).or(Aircraft.where(turboprop: true))
      @entries = Entry.where(aircraft: @turb)
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
end