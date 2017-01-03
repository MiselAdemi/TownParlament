require 'test_helper'

class AmandmenControllerTest < ActionController::TestCase
  setup do
    @amandman = amandmen(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:amandmen)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create amandman" do
    assert_difference('Amandman.count') do
      post :create, amandman: {  }
    end

    assert_redirected_to amandman_path(assigns(:amandman))
  end

  test "should show amandman" do
    get :show, id: @amandman
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @amandman
    assert_response :success
  end

  test "should update amandman" do
    patch :update, id: @amandman, amandman: {  }
    assert_redirected_to amandman_path(assigns(:amandman))
  end

  test "should destroy amandman" do
    assert_difference('Amandman.count', -1) do
      delete :destroy, id: @amandman
    end

    assert_redirected_to amandmen_path
  end
end
