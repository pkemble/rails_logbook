# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

parseJsonFlights = (page_array) ->
  
  
  #first convert the string to a json array
  p_page_array = JSON.parse(page_array)
  
  printedLogbook = ''
  tableHead = "<table class='printed-logbook table table-striped table-condensed table-bordered'>" +
    "<tr><td>Date</td><td>Tail #</td><td>Model</td><td>Dep</td><td>Arr</td><td>Time</td><td>PIC</td><td>SIC</td><td>Night</td><td>Inst.</td><td>Appr.</td></tr>"
  tableFoot = "</table>"
  
  for page, page of p_page_array
    converted = ""
    p_page_flights = JSON.parse(page)
    p_page_totals = JSON.parse(p_page_flights.page_totals)
    p_page_running_total = JSON.parse(p_page_flights.running_total)
      
    for flights, flight of JSON.parse(p_page_flights.page_flights)
      if flight.entry_data.pic
        pic = flight.block_time
        sic = ''
      else
        pic = ''
        sic = flight.block_time
      
      page_flight_conv = "<td>" +
       flight.entry_data.date +
       "</td><td>" + flight.entry_data.tail +
       "</td><td>" + flight.entry_data.ac_model + 
       "</td><td>" + flight.dep + 
       "</td><td>" + flight.arr + 
       "</td><td>" + flight.block_time + 
       "</td><td>" + pic +
       "</td><td>" + sic +
       "</td><td>" + flight.night + 
       "</td><td>" + flight.instrument + 
       "</td><td>" + flight.approaches + "</td>"
       
      converted += "<tr>" + page_flight_conv + "</tr>"
    
    strTotal = "<td>Totals:</td><td colspan=4></td><td>" +
     p_page_totals.block_time + "</td><td>" +
     p_page_totals.pic + "</td><td>" +
     p_page_totals.sic + "</td><td>" +
     p_page_totals.night + "</td><td>" +
     p_page_totals.instrument + "</td><td>" +
     p_page_totals.approaches + "</td>"
     
    converted += "<tr>" + strTotal + "</tr>"
    printedLogbook += tableHead + converted + tableFoot
  $('#printable').html printedLogbook

$(document).ready ->
  if $('#printable').length > 0
    parseJsonFlights($('#printable').attr('data-logbook'))
  return
  