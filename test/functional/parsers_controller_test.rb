require 'test_helper'

class ParsersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parsers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create parser" do
    assert_difference('Parser.count') do
      post :create, :parser => { }
    end

    assert_redirected_to parser_path(assigns(:parser))
  end

  test "should show parser" do
    get :show, :id => parsers(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => parsers(:one).to_param
    assert_response :success
  end

  test "should update parser" do
    put :update, :id => parsers(:one).to_param, :parser => { }
    assert_redirected_to parser_path(assigns(:parser))
  end

  test "should destroy parser" do
    assert_difference('Parser.count', -1) do
      delete :destroy, :id => parsers(:one).to_param
    end

    assert_redirected_to parsers_path
  end
end
