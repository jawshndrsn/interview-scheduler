require 'test_helper'

class InterviewerPoolsControllerTest < ActionController::TestCase
  setup do
    @interviewer_pool = interviewer_pools(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:interviewer_pools)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create interviewer_pool" do
    assert_difference('InterviewerPool.count') do
      post :create, :interviewer_pool => @interviewer_pool.attributes
    end

    assert_redirected_to interviewer_pool_path(assigns(:interviewer_pool))
  end

  test "should show interviewer_pool" do
    get :show, :id => @interviewer_pool
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @interviewer_pool
    assert_response :success
  end

  test "should update interviewer_pool" do
    put :update, :id => @interviewer_pool, :interviewer_pool => @interviewer_pool.attributes
    assert_redirected_to interviewer_pool_path(assigns(:interviewer_pool))
  end

  test "should destroy interviewer_pool" do
    assert_difference('InterviewerPool.count', -1) do
      delete :destroy, :id => @interviewer_pool
    end

    assert_redirected_to interviewer_pools_path
  end
end
