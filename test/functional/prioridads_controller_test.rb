require 'test_helper'

class PrioridadsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:prioridads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create prioridad" do
    assert_difference('Prioridad.count') do
      post :create, :prioridad => { }
    end

    assert_redirected_to prioridad_path(assigns(:prioridad))
  end

  test "should show prioridad" do
    get :show, :id => prioridads(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => prioridads(:one).to_param
    assert_response :success
  end

  test "should update prioridad" do
    put :update, :id => prioridads(:one).to_param, :prioridad => { }
    assert_redirected_to prioridad_path(assigns(:prioridad))
  end

  test "should destroy prioridad" do
    assert_difference('Prioridad.count', -1) do
      delete :destroy, :id => prioridads(:one).to_param
    end

    assert_redirected_to prioridads_path
  end
end
