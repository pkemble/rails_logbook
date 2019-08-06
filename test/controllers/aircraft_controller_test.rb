require 'test_helper'

class AircraftControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get aircraft_create_url
    assert_response :success
  end

  test "should get update" do
    get aircraft_update_url
    assert_response :success
  end

end
