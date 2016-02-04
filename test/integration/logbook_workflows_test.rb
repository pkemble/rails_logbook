require 'test_helper'

class LogbookWorkflowsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
		@flight = flights(:simple_flight)
		@entry = Entry.find_by_id(@flight.entry_id)
		@user = @entry.user
  end
  
  # create a flight, edit with an error, and delete
  test "flight_workflow" do
  	assert_not_nil @flight
  	assert_not_nil @entry
  	#show the flight
  	get edit_entry_flight_path(@entry.id, @flight.id)
  	assert_template 'flights/edit', partial: 'flights/_flights_form'
  	assert_template layout: 'layouts/application'
  	#edit/update the flight with a good time
  	patch_via_redirect(entry_flight_path, flight: { blockout: "1303" })
		assert_template 'entries/edit'
  	#destroy the flight record
  	delete_via_redirect(entry_flight_path(@entry.id, @flight.id))
  	assert_template 'entries/edit'
  	
  end
  
  test "only_logged_in_users" do
    #TODO expand these to flights and users
    get edit_entry_path(@entry.id)
    assert_not flash.empty?
    assert_redirected_to login_url
    
    #patch
    patch entry_path(id: @entry, entry: { date: @entry.date, pd_start: "0400", pd_end: "2300" })
    assert_not flash.empty?
    assert_redirected_to login_url
  end
end
