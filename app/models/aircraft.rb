class Aircraft < ApplicationRecord
  self.table_name = "aircraft" #sheesh..."aircraft".pluralize => "aircrafts"

  has_many :entries
end