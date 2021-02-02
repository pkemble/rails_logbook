# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

validKeys = ->
  if event.shiftKey and event.keyCode == 9 or event.keyCode == 9 or event.shiftKey
    return false
  true

validateBlockTime = (input, bTime) ->
  #return false
  #TODO is this needed?
  if bTime.length < 4
    return false
  th = parseInt(bTime.substring(0, 2))
  tm = parseInt(bTime.substring(2, 4))
  if th > 23 | tm > 59
    input.css 'color', 'red'
    return false
  else
    input.css 'color', ''
  true

$(document).ready ->
  $('.blocktimefield').keyup ->
    bTime = $(this).val()
    if validateBlockTime($(this), bTime) and validKeys()
      $(this).parent().next().find('input').focus()
    return
  return