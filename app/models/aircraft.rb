class Aircraft < ApplicationRecord
  self.table_name = "aircraft" #sheesh..."aircraft".pluralize => "aircrafts"

  has_many :entries
  belongs_to :user
  
  def entry_num
    return Aircraft.joins(:entries).where(entries: { aircraft: self.id }).count
  end
  
  def self.populate_ac_data
    Aircraft.where('ac_model LIKE ?', 'PC12%').update_all(turboprop: true, efis: true, turb: true)
    Aircraft.where('ac_model LIKE ?', 'BE%').update_all(multi: true, efis: true, glass: true, turb: true, fadec: true)
    Aircraft.where('ac_model LIKE ?', 'PA44180').update_all(multi: true)
  end
  
end