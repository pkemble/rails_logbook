class Airport < ActiveRecord::Base
  API = 'http://api.sunrise-sunset.org/'

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
    CSV.foreach(csv_file.path, headers: true, encoding: 'iso-8859-1') do |row|
      @crow = Airport.new
      @crow.name = row['name']
      @crow.city = row['city']
      @crow.country = row['country']
      @crow.icao = row['icao']
      @crow.iata = row['iata']
      @crow.lat = row['lat'].to_f
      @crow.lon = row['lon'].to_f
      @crow.elev = row['elev'].to_f
      @crow.tz = row['tz']
      @crow.dst = row['dst']
      @crow.olsontz = row['olsontz']
      @crow.used = 0
      @crow.iata = @crow.icao.remove_icao if @crow.iata == '\\N'
      @crow.save!
    end
  end

  def get_lat
    lat
  end

  def get_lon
    lon
  end

  def self.add_missing_airport(iata, used = 0)
    missing = Airport.new
    missing.iata = iata
    missing.icao = iata # this isn't the best but...'
    missing.used = used
    missing.save!
    return missing
  end

	def self.search_multiple(q)
		#return Airport.where("icao LIKE ? or iata LIKE ?", "#{q}%", "#{q}%").limit(10).order(:icao)
		return Airport.where("icao LIKE ?", "%#{q}%").limit(20).order(used: :desc)
	end

  def self.search(q, create = false)
    apt = Airport.where(icao: q).or(Airport.where(iata: q)).or(Airport.where(icao: q.add_icao)).first
		if apt.nil? && create 
			return Airport.add_missing_airport(q, 1) 
    end
		return apt
  end
	
	def update_usage
		if self.used.nil?
			self.used = 1
		else
			self.used += 1
		end
		self.save!
	end
end
