require 'test_helper'

class InstallControllerTest < ActionController::TestCase
  test "should get local" do
    get :local
    assert_response :success
  end

  test "should get server" do
    get :server
    assert_response :success
  end

end
