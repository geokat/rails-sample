require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
  setup do
    @group = groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group" do
    assert_difference('Group.count') do
      post :create, group: { balance: @group.balance, name: @group.name, private: @group.private }
    end

    assert_redirected_to group_path(assigns(:group))
  end

  test "should show group" do
    get :show, id: @group
    assert_response :success
  end

  test "should show group as padded JSON when callback parameter is passed" do
    get :show, {id: @group, format: 'json', callback: 'cb'}
    assert_match /cb\({/, response.body.to_s
  end

  test "should return success on show nonexistent group JSONP request" do
    get :show, {id: 51583, format: 'json', callback: 'cb'}
    assert_response :success
  end

  test "should include error inside padded JSON on show nonexistent group JSONP request" do
    get :show, {id: 51583, format: 'json', callback: 'cb'}
    assert_match /cb\({.+not_found/, response.body.to_s
  end

  test "should get edit" do
    get :edit, id: @group
    assert_response :success
  end

  test "should update group" do
    patch :update, id: @group, group: { balance: @group.balance, name: @group.name, private: @group.private }
    assert_redirected_to group_path(assigns(:group))
  end

  test "should destroy group" do
    assert_difference('Group.count', -1) do
      delete :destroy, id: @group
    end

    assert_redirected_to groups_path
  end
end
