desc 'Populates A/C data as found in /lib/tasks/populate_ac_data.rake'
namespace :db do
  task :populate_ac_data => :environment do
		Aircraft.populate_ac_data
    p 'Complete!'
  end
end
