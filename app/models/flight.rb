# class BlocktimeValidator < ActiveModel::EachValidator
  # def validate_each(rec, attr, val)
    # barr = val.scan(/.{2}/)
    # unless val.length == 4 && barr[0].to_i.between?(00,23) && barr[1].to_i.between?(00,59)
      # str_msg = 'Time doesn\'t seem to fit convention: HHMM' # + barr[0] + ' - ' + barr[1]
      # rec.errors.add(attr, str_msg)
    # end
  # end
# end

class Flight < ActiveRecord::Base
    
  belongs_to :entry
  
  validates :dep, :arr, :presence => true
  validates :blockout, :blockin, :time_format => true
  #validates :night, :if "night < total_time"
  
  require 'stringutil'
  
  before_save do
    self.dep = self.dep.icao
    self.arr = self.arr.icao
    self.p_blockout = to_utc(blockout)
    self.p_blockin = to_utc(blockin)
    get_total_time
  end
  
  def get_total_time
    d1 = DateTime.strptime(blockout.to_s, '%H%M')
    d2 = DateTime.strptime(blockin.to_s, '%H%M')
    
    if d2 < d1
      d1 = d1.prev_day
    end
    
    self.total_time = ((d2.to_time - d1.to_time) / 3600 ).round(1)
  end
  
  private
    def to_utc(btime)
      DateTime.strptime(btime.to_s, "%H%M").to_time.utc
    end
end
