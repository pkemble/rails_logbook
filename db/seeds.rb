# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name: "Seedy Kemble", email: "pkemble_seed@gmail.com", password: "zxcvbnm,.", password_confirmation: "zxcvbnm,.")
# 
# 50.times do |n|
  # date = rand(Date.civil(2013, 8, 5)..Date.civil(2016, 2, 1))
  # tail = "N656AF"
  # per_diem_hours = 24
#   
  # Entry.create( date: date,
                # tail: tail,
                # per_diem_hours: per_diem_hours,
                # user: User.find_by(email: "pkemble_seed@gmail.com") )
# end


