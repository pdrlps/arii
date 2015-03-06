require 'test_helper'

class LibraryControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get inputs" do
    get :inputs
    assert_response :success
  end

  test "should get outputs" do
    get :outputs
    assert_response :success
  end

  test "should get integrations" do
    get :integrations
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get get" do
    get :get
    assert_response :success
  end

end
