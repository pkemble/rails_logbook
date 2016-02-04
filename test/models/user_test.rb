require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(email: "pkemble@gmail.com", name: "pete kemble", uname: "pkemble" )
  end
  
  test "should be valid" do
    assert @user.valid?
  end
end
