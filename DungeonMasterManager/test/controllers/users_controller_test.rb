require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    create_user('Test', 'test@dmm.com', 'testtest')
    @user = User.find_by_name('Test')
  end

  test 'should show user' do
    login(@user.email, 'testtest')
    get user_url(@user)
    assert_response :success
  end

  test 'should show new user form' do
    get new_user_url
    assert_response :success
  end

  test 'should not show new user form' do
    login(@user.email, 'testtest')
    get new_user_url
    assert_response :redirect
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { email: 'test2@dmm.com', name: 'Test2', password: 'testtest', password_confirmation: 'testtest' } }
    end

    assert_redirected_to login_url
    assert_equal 'Wellcome, %s! You have successfully registered.' % ['Test2'], flash[:success]
  end

  test "should show new user form with errors if user creation fails" do
    assert_no_difference('User.count') do
      post users_url, params: { user: { email: 'nonvalidemail', name: @user.name, password: 'testtest' } }
    end

    assert_redirected_to new_user_url
    assert_equal 'Hmm... There seems to be some errors.', flash[:error]
  end

  test "should not create user when password confirm does not match" do
    assert_no_difference('User.count') do
      post users_url, params: { user: { email: @user.email, name: @user.name, password: 'testtest', password_confirmation: 'notsamepassword' } }
    end
  end

  test "should not create user when mail, name, password/password confirmation are missing" do
    assert_no_difference('User.count') do
      post users_url, params: { user: { name: @user.name, password: 'testtest', password_confirmation: 'testtest' } }
    end

    assert_no_difference('User.count') do
      post users_url, params: { user: { email: @user.email, password: 'testtest', password_confirmation: 'testtest' } }
    end

    assert_no_difference('User.count') do
      post users_url, params: { user: { email: @user.email, name: @user.name, password: 'testtest' } }
    end

    assert_no_difference('User.count') do
      post users_url, params: { user: { email: @user.email, name: @user.name } }
    end

  end

  test "should get edit" do
    login(@user.email, 'testtest')
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    login(@user.email, 'testtest')
    patch user_url(@user), params: { user: { name: 'Iron Edited' } }
    assert_response :success
    assert @user.name, 'Iron Edited'
  end

  test "should destroy user" do
    login(@user.email, 'testtest')
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to root_url
  end

end
