class Airport < ActiveRecord::Base

  API = "http://api.sunrise-sunset.org/"

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
