json.array!(@apts) do | apt |
  json.apt apt.icao #+ ', ' + apt.name + ', ' + apt.state
end