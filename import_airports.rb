Airport.delete_all
puts "Airport database cleansed"
cnt = 0
total = 0
CSV.foreach("aptdb.csv", :headers => true) do |r|
	total += 1
	if Airport.create!(r.to_hash)
		cnt += 1
	end
end

puts "Inserted #{cnt} out of #{total} airports."

