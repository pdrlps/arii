require 'test_helper'

class BetasControllerTest < ActionController::TestCase
  setup do
    @beta = betas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:betas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create beta" do
    assert_difference('Betas.count') do
      post :create, beta: { email: @beta.email, job: @beta.job, name: @beta.name, origin: @beta.origin, payload: @beta.payload, what: @beta.what }
    end

    assert_redirected_to beta_path(assigns(:beta))
  end

  test "should show beta" do
    get :show, id: @beta
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @beta
    assert_response :success
  end

  test "should update beta" do
    patch :update, id: @beta, beta: { email: @beta.email, job: @beta.job, name: @beta.name, origin: @beta.origin, payload: @beta.payload, what: @beta.what }
    assert_redirected_to beta_path(assigns(:beta))
  end

  test "should destroy beta" do
    assert_difference('Betas.count', -1) do
      delete :destroy, id: @beta
    end

    assert_redirected_to betas_index_path
  end
end
