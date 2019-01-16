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
		CSV.foreach(csv_file.path, :headers => true) do |row|
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
	
  def get_sun(dt)
    byebug
    date = dt.strftime("%Y-%m-%d")
    options = {
      "lat" => self.lat.to_s,
      "lng" => self.lon.to_s,
      "date" => date
    }
    srss_url = "#{API}json"

    begin
      response = HTTParty.get(srss_url, :query => options)

      sun = JSON.parse(response.body)

    rescue
      return nil
    end

  end
end
