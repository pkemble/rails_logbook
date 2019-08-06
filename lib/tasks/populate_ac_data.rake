desc 'Populates A/C data as found in /lib/tasks/populate_ac_data.rake'
namespace :db do
  task :populate_ac_data => :environment do
    Aircraft.where('ac_model LIKE ?', 'PC12%').update_all(turboprop: true, efis: true, turb: false)
    Aircraft.where('ac_model LIKE ?', 'BE400%').update_all(multi: true, efis: true, glass: true, turb: true, fadec: true)
    p 'Complete!'
  end
end
