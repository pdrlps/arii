require 'test_helper'

class TemplatesControllerTest < ActionController::TestCase
  setup do
    @template = templates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:templates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create template" do
    assert_difference('Template.count') do
      post :create, template: { count: @template.count, created_at: @template.created_at, help: @template.help, identifier: @template.identifier, last_execute_at: @template.last_execute_at, memory: @template.memory, payload: @template.payload, publisher: @template.publisher, title: @template.title, updated_at: @template.updated_at, variables: @template.variables }
    end

    assert_redirected_to template_path(assigns(:template))
  end

  test "should show template" do
    get :show, id: @template
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @template
    assert_response :success
  end

  test "should update template" do
    patch :update, id: @template, template: { count: @template.count, created_at: @template.created_at, help: @template.help, identifier: @template.identifier, last_execute_at: @template.last_execute_at, memory: @template.memory, payload: @template.payload, publisher: @template.publisher, title: @template.title, updated_at: @template.updated_at, variables: @template.variables }
    assert_redirected_to template_path(assigns(:template))
  end

  test "should destroy template" do
    assert_difference('Template.count', -1) do
      delete :destroy, id: @template
    end

    assert_redirected_to templates_path
  end
end
