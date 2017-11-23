require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    create_user('Test', 'test@dmm.com', 'testtest')
  end

  test 'login with existing user and valid password' do
    login('test@dmm.com', 'testtest')

    assert_redirected_to root_url
    assert flash[:success], 'Greetings, Test!'
  end

  test 'login with existing user and non valid password' do
    login('test@dmm.com', 'nonvalidpassword')

    assert_redirected_to login_path
    assert_equal flash[:error], 'Incorrect user/password combination provided'
  end

  test 'login with non existing user' do
    login('nonuser@dmm.com', 'nonuser')

    assert_redirected_to login_url
    assert_equal flash[:error], 'Incorrect user/password combination provided'
  end

  test 'logout when already logged in' do
    login('test@dmm.com', 'testtest')
    get logout_url

    assert_redirected_to root_url
  end

  test 'logout when not logged in' do
    get logout_url

    assert_redirected_to login_url
  end

end
