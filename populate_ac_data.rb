Aircraft.where('ac_model LIKE ?', 'PC12%').update_all(turboprop: true, efis: true, turbine: false)
Aircraft.where('ac_model LIKE ?', 'BE400%').update_all(multi: true, efis: true, glass: true, turb: true, fadec: :true)
puts "A/C data populated from #{__FILE__}"