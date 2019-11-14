class FlightSerializer < ActiveModel::Serializer
  attributes :id, :date, :tail, :ac_model, :dep, :arr, :block_time, :pic, :sic, :sesic, :sepic, :setb, :metb, :mesic, :mepic, :night, :instrument, :approaches, :pf, :remarks
  
  def date
    return object.entry.nice_date
  end
  
  def tail
    return object.entry.aircraft.tail
  end

  def ac_model
    return object.entry.aircraft.ac_model
  end  
  
  def pic
    if object.entry.pic
      return object.block_time
    else
      return "0"
    end
  end
  
  def sic
    if object.entry.pic
      return "0"
    else
      return object.block_time
    end
  end
  
  #metb
  def metb
    if object.entry.aircraft.turb and ( object.entry.aircraft.multi )
      return object.block_time
    else
      return "0"
    end
  end
  #setb
  def setb
    if object.entry.aircraft.turb and ( !object.entry.aircraft.multi )
      return object.block_time
    else
      return "0"
    end
  end
  #mesic
  def mesic
    if object.entry.aircraft.multi and ( !object.entry.pic )
      return object.block_time
    else
      return "0"
    end
  end
  #sesic
  def sesic
    if !object.entry.aircraft.multi and ( !object.entry.pic )
      return object.block_time
    else
      return "0"
    end
  end
  #mepic
  def mepic
    if object.entry.aircraft.multi and ( object.entry.pic )
      return object.block_time
    else
      return "0"
    end
  end
  #sepic
  def sepic
    if !object.entry.aircraft.multi and ( object.entry.pic )
      return object.block_time
    else
      return "0"
    end
  end
  
#override null showing up
#  def serializable_hash(adapter_options = nil, options = {}, adapter_instance = self.class.serialization_adapter_instance)
#    hash = super
#    hash.each { |key, value| hash[key] = 0 if value.nil? }
#    hash
#  end  
  
  
#  def entry_data
#    entry_data = { "date" => object.entry.nice_date, "tail" => object.entry.tail, "ac_model" => object.entry.ac_model, "pic" => object.entry.pic }
#  end
  
end
