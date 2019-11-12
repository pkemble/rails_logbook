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
			@crow.lat = row["lat"].to_f
			@crow.lon = row["lon"].to_f
			@crow.elev = row["elev"].to_f
			@crow.tz = row["tz"]
			@crow.dst = row["dst"]
			@crow.olsontz = row["olsontz"]
			@crow.used = 0
			if @crow.iata == "\\N"
			  @crow.iata = @crow.icao.remove_icao
			end
			@crow.save!
		end
		
	end	

	def get_lat
	  return self.lat
	end
	
	def get_lon
	  return self.lon
	end

	def self.add_missing_airport(iata, used = 0)
	  unless Airport.where(iata: iata).count > 0
      @missing = Airport.new()
      @missing.iata = iata
      @missing.icao = iata #this isn't the best but...'
      @missing.used = used
      @missing.save!
	  end
	end
end
