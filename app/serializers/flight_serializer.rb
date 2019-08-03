class FlightSerializer < ActiveModel::Serializer
  attributes :id, :entry_data, :dep, :arr, :block_time, :night, :instrument, :approaches, :pf, :remarks
  
  def entry_data
    entry_data = { "date" => object.entry.nice_date, "tail" => object.entry.tail, "ac_model" => object.entry.ac_model, "pic" => object.entry.pic }
  end
  
end
