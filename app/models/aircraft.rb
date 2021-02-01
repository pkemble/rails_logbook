class Aircraft < ApplicationRecord
  self.table_name = "aircraft" #sheesh..."aircraft".pluralize => "aircrafts"

  has_many :entries
  belongs_to :user
end