class EntrySerializer < ActiveModel::Serializer
  has_many :flights
  
  attributes :id, :nice_date, :ac_model, :tail
end
