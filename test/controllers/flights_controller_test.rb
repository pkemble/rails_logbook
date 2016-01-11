require 'test_helper'

class FlightsControllerTest < ActionController::TestCase
  setup do
    @flight = flights(:simple_flight)
    @flight.save #this is to generate total_time et al.
    @entry = Entry.find_by_id(@flight.entry_id)
  end

  # test "should get index" do
    # get :index
    # assert_response :success
    # assert_not_nil assigns(:flights)
  # end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create flight" do
    assert_difference('Flight.count') do
      post :create, flight: { dep: "fll", arr: "mdw", blockout: "1500", blockin: "1800" }
    end

    assert_redirected_to new_entry_flight_path
  end

  test "should show flight" do
    get :show, id: @flight
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @flight
    assert_response :success
  end

  test "should update flight" do
    patch :update, id: @flight, flight: { approaches: 1 }
    assert_redirected_to edit_entry_path(assigns(@entry))
  end

  test "should destroy flight" do
    assert_not_nil assigns(:entry)
    assert_difference('Flight.count', -1) do
      delete :destroy, id: @flight
      assert_redirected_to edit_entry_path(assigns(:entry))
    end

    assert_redirected_to edit_entry_path(assigns(@entry))
  end
end
