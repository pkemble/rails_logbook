class Airport < ActiveRecord::Base

  API = "http://api.sunrise-sunset.org/"
	
# "id",
# "name",
# "city",
# "country",
# "iata",
# "icao",
# "lat",
# "lon",
# "elev",
# "tz",
# "dst",
# "olsontz",
# "created_at",
# "updated_at"
	
	def self.import(csv_file)
		Airport.delete_all
		CSV.foreach(csv_file.path, :headers => true, :encoding => 'iso-8859-1') do |row|
			@crow = Airport.new()
			@crow.name = row["name"]
			@crow.city = row["city"]
			@crow.country = row["country"]
			@crow.icao = row["icao"]
			@crow.iata = row["iata"]
			@crow.lat = row["lat"]
			@crow.lon = row["lon"]
			@crow.elev = row["elev"]
			@crow.tz = row["tz"]
			@crow.dst = row["dst"]
			@crow.olsontz = row["olsontz"]
			@crow.save!
		end
	end	

	def self.add_missing_airport(iata)
	  unless Airport.where(iata: iata).count > 0
	    byebug
      @missing = Airport.new()
      @missing.iata = iata
      @missing.save!
	  end
	end
end
