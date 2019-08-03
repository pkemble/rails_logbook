class FlightSerializer < ActiveModel::Serializer
  attributes :id, :date, :tail, :ac_model, :dep, :arr, :block_time, :pic, :sic, :night, :instrument, :approaches, :pf, :remarks
  
  def date
    return object.entry.nice_date
  end
  
  def tail
    return object.entry.tail
  end

  def ac_model
    return object.entry.ac_model
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
  
#  def entry_data
#    entry_data = { "date" => object.entry.nice_date, "tail" => object.entry.tail, "ac_model" => object.entry.ac_model, "pic" => object.entry.pic }
#  end
  
end
