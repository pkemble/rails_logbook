# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
addCellsToArr = (arrData) ->
  celledData = ''
  for key, data of arrData
    celledData += '<td>' + data + '</td>'
    
  return celledData

parseJsonFlights = (page_array) ->
  
  
  #first convert the string to a json array
  p_page_array = JSON.parse(page_array)
  
  printedLogbook = ''
  arrTableHead = ['Date', 'Tail', 'Model', 'Dep', 'Arr', 'Time', 'SE PIC', 'SE SIC', 'ME PIC', 'ME SIC','SE Turb.', 'ME Turb', 'Night', 'Inst.', 'Appr.']
  tableTag = "<table class='printed-logbook table table-striped table-condensed table-bordered'>"
  tableHead = "<tr>" + addCellsToArr(arrTableHead) + "</tr>"
  tableFoot = "</table>"
  
  for page, page of p_page_array
    converted = ""
    p_page_flights = JSON.parse(page)
    p_page_totals = JSON.parse(p_page_flights.page_totals)
    p_page_running_total = JSON.parse(p_page_flights.running_total)
      
    for flights, flight of JSON.parse(p_page_flights.page_flights)
      arr_page_flight_conv = [ flight.date, flight.tail, flight.ac_model, flight.dep, flight.arr, 
        flight.block_time, flight.sepic, flight.sesic, flight.mepic, flight.mesic, flight.setb, 
        flight.metb, flight.night, flight.instrument, flight.approaches ]
        
      page_flight_conv = addCellsToArr(arr_page_flight_conv) 
      converted += "<tr>" + page_flight_conv + "</tr>"
    
    strTotalTitle = "<tr><td>Page Totals:</td><td colspan=4></td>"
    arrPageTotals = [
     p_page_totals.block_time,
     p_page_totals.sepic,
     p_page_totals.sesic,
     p_page_totals.mepic,
     p_page_totals.mesic,
     p_page_totals.setb,
     p_page_totals.metb,
     p_page_totals.night,
     p_page_totals.instrument,
     p_page_totals.appr ]
     
    strRunningTotal = "<td>Totals:</td><td colspan=4></td>"
    arrPageRunningTotal = [
     p_page_running_total.block_time,
     p_page_running_total.sepic,
     p_page_running_total.sesic,
     p_page_running_total.mepic,
     p_page_running_total.mesic,
     p_page_running_total.setb,
     p_page_running_total.metb,
     p_page_running_total.night,
     p_page_running_total.instrument,
     p_page_running_total.appr ]
     
    converted += "<tr>" + strTotalTitle + addCellsToArr(arrPageTotals) + "</tr>" + 
      "<tr>" + strRunningTotal + addCellsToArr(arrPageRunningTotal) + "</tr>"
    printedLogbook += tableTag + tableHead + converted + tableFoot
  $('#printable').html printedLogbook

$(document).ready ->
  if $('#printable').length > 0
    parseJsonFlights($('#printable').attr('data-logbook'))
  return
  