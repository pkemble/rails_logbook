json.array!(@apts) do | apt |
  json.apt apt.icao + ', ' + apt.city + ', ' + apt.state
	json.link url_for([:edit, apt])
end