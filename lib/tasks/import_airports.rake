require 'csv'
  namespace :db do
    namespace :airports do
      task :import, [:filename]  => [:environment] do | task, args |
      Airport.delete_all
      t = File.read(args[:filename])
      if args[:filename].include? '.json'
        airports = JSON.parse(t)
				apt_num = airports.count
        airports.each do | airport |
          new_airport = Airport.create!(airport[1].to_h)
					apt_num = apt_num - 1
					print airport[0] + " : " + apt_num.to_s + " to go...\r"
					$stdout.flush
        end
      else
        csv = CSV.parse(t, :headers => true)
        csv.each do |row|
          Airport.create!(row.to_hash)
        end
      end
    end
  end
end
