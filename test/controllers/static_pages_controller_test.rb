require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get tripsheet" do
    get :tripsheet
    assert_response :success
  end

end
