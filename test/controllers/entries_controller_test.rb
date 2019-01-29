require 'test_helper'

class EntriesControllerTest < ActionController::TestCase
  setup do
    @entry = entries(:simple_entry)
    @entry.flights.each do |f|
      f.save #this is to generate total_time et al.
    end
  end

#  test "should get index" do
#    get :index
#    assert_redirected_to root_path
#  end
#
#  test "should get new" do
#    get :new
#    assert_response :success
#  end
#
#  test "should create entry" do
#    assert_difference('Entry.count') do
#      post :create, entry: { date: "2015-01-03", tail: "708", flight_number: "976", crew_name: "bob bob" }
#    end
#    assert_redirected_to edit_entry_path(assigns(:entry))
#  end
#
#	test "should show entry" do
#    get :show, id: @entry
#    assert_response :success
#  end
#
#  test "should get edit" do
#    get :edit, id: @entry
#    assert_response :success
#  end
#
#  test "should update entry" do
#    patch :update, id: @entry, entry: { crew_meal: 1 }
#    assert_redirected_to root_path
#  end
#
#  test "should destroy entry" do
#    flunk("TODO")
#    assert_difference('Entry.count', -1) do
#      delete :destroy, id: @entry
#    end
#    assert_redirected_to root_path
#  end
end
