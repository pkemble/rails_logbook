desc 'Exports logbook to an astro seed style csv'

namespace :db do
  namespace :export do
    task :seed => :environment do
      csv = "DepartureTimeLocal,OriginAirport,DestinationAirport,AircraftType,AircraftRegistration,DayTakeoffs,"\
        "NightTakeoffs,DayLandings,NightLandings,BlockTimefromFlight,NightTime,PicTime,SicTime,MELPicTime,MELSicTime,"\
        "HoldTime,PrecApproaches,Approaches,PIC,SIC,dual_given,dual_recvd,block_out,block_in\n"
      
      flights = Flight.all
      flights.each do |flight|
        if(flight.entry.pic?)
          pic_name = User.find(flight.entry.user_id).name
          sic_name = flight.entry.crew_name
        else
          pic_name = flight.entry.crew_name
          sic_name = User.find(flight.entry.user_id).name
        end
        
        f = FlightSerializer.new(flight)
        unless flight.blockout.nil?
          blockout = flight.blockout[0..1] + ":" + flight.blockout[2..3]
          blockin = flight.blockin[0..1] + ":" + flight.blockin[2..3]
        else
          blockout = ""
          blockin = ""
        end
        
        
        f_prop_array = [ f.date, flight.dep, flight.arr, f.ac_model, f.tail, flight.day_to, flight.night_to, 
          flight.day_ld, flight.night_ld, flight.block_time, flight.night, f.pic, f.sic, f.mepic,
          f.mesic, "0", flight.approaches, "0", pic_name, sic_name, "0", "0", blockout, blockin]
        
        f_prop_array.each do |prop|
          csv += hopper(prop)
        end
        csv = csv.delete_suffix(',')
        csv += "\n"
      end
      filename = 'logbook-export-' + DateTime.now.strftime('%m-%d-%Y-%T') + '.csv'
      open( filename, 'w') { |file|
        file << csv
      }
      puts 'Exported to ' + filename
    end
    
    def hopper(prop)
      if prop.nil?
        prop = "0"
      end
      return prop.to_s + "," 
    end
  
  end
end  


