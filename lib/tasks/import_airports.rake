require 'csv'
  namespace :airports do
    task :import => :environment do
    t = File.read('aptdb.csv')
    csv = CSV.parse(t, :headers => true)
    csv.each do |row|
      Airport.create!(row.to_hash)
    end
  end
end
