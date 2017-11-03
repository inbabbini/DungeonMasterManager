require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:iron)
  end

  test 'should show user' do
    get user_url(@user)
    assert_response :success
  end

  test 'should show new user form' do
    get new_user_url
    assert_response :success
  end

  test 'should not show new user form' do
    login(@user)
    get new_user_url
    assert_response :redirect
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { email: @user.email, name: @user.name, password: 'ironiron', password_confirmation: 'ironiron' } }
    end

    assert_redirected_to root_url
    assert_equal 'Wellcome, %s! You have successfully registered.' % [@user.name], flash[:success]
  end

  test "should not create user" do
    assert_no_difference('User.count') do
      post users_url, params: { user: { email: @user.email, name: @user.name, password: 'ironiron', password_confirmation: 'notsamepassword' } }
    end

    assert_redirected_to new_user_url
    assert_equal 'Hmm... There seems to be some errors.', flash[:error]
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch skill_url(@user), params: { user: { name: 'Iron Edited' } }
    assert_redirected_to root_url
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(User.last)
    end

    assert_redirected_to root_url
  end

end
