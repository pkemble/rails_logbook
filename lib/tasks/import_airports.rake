require 'csv'
  namespace :db do
    namespace :airports do
      task :import, [:filename]  => [:environment] do | task, args |
      Airport.delete_all
      t = File.read(args[:filename])
      csv = CSV.parse(t, :headers => true)
      csv.each do |row|
        Airport.create!(row.to_hash)
      end
    end
  end
end
