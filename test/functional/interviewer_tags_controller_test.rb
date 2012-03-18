require 'test_helper'

class InterviewerTagsControllerTest < ActionController::TestCase
  setup do
    @interviewer_tag = interviewer_tags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:interviewer_tags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create interviewer_tag" do
    assert_difference('InterviewerTag.count') do
      post :create, :interviewer_tag => @interviewer_tag.attributes
    end

    assert_redirected_to interviewer_tag_path(assigns(:interviewer_tag))
  end

  test "should show interviewer_tag" do
    get :show, :id => @interviewer_tag
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @interviewer_tag
    assert_response :success
  end

  test "should update interviewer_tag" do
    put :update, :id => @interviewer_tag, :interviewer_tag => @interviewer_tag.attributes
    assert_redirected_to interviewer_tag_path(assigns(:interviewer_tag))
  end

  test "should destroy interviewer_tag" do
    assert_difference('InterviewerTag.count', -1) do
      delete :destroy, :id => @interviewer_tag
    end

    assert_redirected_to interviewer_tags_path
  end
end
