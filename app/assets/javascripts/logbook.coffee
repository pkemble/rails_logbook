# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

parseJsonFlights = (page_array) ->
  
  
  #first convert the string to a json array
  p_page_array = JSON.parse(page_array)
  
  printedLogbook = ''
  tableHead = "<table class='printed-logbook table table-striped table-condensed table-bordered'>" +
    "<tr><td>Date</td><td>Tail #</td><td>Model</td><td>Dep</td><td>Arr</td>
    <td>Time</td><td>SE PIC</td><td>SE SIC</td><td>ME PIC</td><td>ME SIC</td>
    <td>SE Turb.</td><td>ME Turb.</td>
    <td>Night</td><td>Inst.</td><td>Appr.</td></tr>"
  tableFoot = "</table>"
  
  for page, page of p_page_array
    converted = ""
    p_page_flights = JSON.parse(page)
    p_page_totals = JSON.parse(p_page_flights.page_totals)
    p_page_running_total = JSON.parse(p_page_flights.running_total)
      
    for flights, flight of JSON.parse(p_page_flights.page_flights)
      page_flight_conv = "<td>" +
       flight.date +
       "</td><td>" + flight.tail +
       "</td><td>" + flight.ac_model + 
       "</td><td>" + flight.dep + 
       "</td><td>" + flight.arr + 
       "</td><td>" + flight.block_time + 
       "</td><td>" + flight.sepic +
       "</td><td>" + flight.sesic +
       "</td><td>" + flight.mepic +
       "</td><td>" + flight.mesic +
       "</td><td>" + flight.setb +
       "</td><td>" + flight.metb +
       "</td><td>" + flight.night + 
       "</td><td>" + flight.instrument + 
       "</td><td>" + flight.approaches + "</td>"
       
      converted += "<tr>" + page_flight_conv + "</tr>"
    
    strTotal = "<td>Page Totals:</td><td colspan=4></td><td>" +
     p_page_totals.block_time + "</td><td>" +
     p_page_totals.sepic + "</td><td>" +
     p_page_totals.sesic + "</td><td>" +
     p_page_totals.mepic + "</td><td>" +
     p_page_totals.mesic + "</td><td>" +
     p_page_totals.setb + "</td><td>" +
     p_page_totals.metb + "</td><td>" +
     p_page_totals.night + "</td><td>" +
     p_page_totals.instrument + "</td><td>" +
     p_page_totals.appr + "</td>"
     
    strRunningTotal = "<td>Totals:</td><td colspan=4></td><td>" +
     p_page_running_total.block_time + "</td><td>" +
     p_page_running_total.sepic + "</td><td>" +
     p_page_running_total.sesic + "</td><td>" +
     p_page_running_total.mepic + "</td><td>" +
     p_page_running_total.mesic + "</td><td>" +
     p_page_running_total.setb + "</td><td>" +
     p_page_running_total.metb + "</td><td>" +
     p_page_running_total.night + "</td><td>" +
     p_page_running_total.instrument + "</td><td>" +
     p_page_running_total.appr + "</td>"
     
    converted += "<tr>" + strTotal + "</tr>" + "<tr>" + strRunningTotal + "</td>"
    printedLogbook += tableHead + converted + tableFoot
  $('#printable').html printedLogbook

$(document).ready ->
  if $('#printable').length > 0
    parseJsonFlights($('#printable').attr('data-logbook'))
  return
  