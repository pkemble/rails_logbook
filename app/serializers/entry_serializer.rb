class EntrySerializer < ActiveModel::Serializer
  has_many :flights
  
  attributes :id, :nice_date
end
