class Flight < ActiveRecord::Base
  
  require 'hobbstime'
  require 'stringutil'
    
  belongs_to :entry
  
  attr_accessor :last_loc, :n_curr
  
  validates :dep, :arr, :pf, :presence => true
  validates :blockout, :blockin, :time_format => true, :presence => true
  #validates :night, :if "night < total_time" # TODO
  
  before_save do
    self.dep = self.dep.icao
    self.arr = self.arr.icao
    @f_hobbs_time = HobbsTime.new(blockout, blockin, entry.date)
    self.p_blockout = @f_hobbs_time.hobbs_start
    self.p_blockin = @f_hobbs_time.hobbs_end
    self.total_time = @f_hobbs_time.span
  end
  
  def n_curr #not used
    a = self.night_to ? self.night_to : "0" 
    b = self.night_ld ? sefl.night_ld : "0"
    n_curr = a + "/" + b    
  end
  
  private
    def to_utc(btime)
      DateTime.strptime(btime.to_s, "%H%M").to_time.utc
    end
end
