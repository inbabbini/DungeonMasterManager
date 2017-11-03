require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "does not save without presence-required properties" do
    new_user = User.new
    assert_not new_user.save

    new_user.name = 'Name'
    assert_not new_user.save

    new_user.email = 'test@mail.com'
    assert_not new_user.save

    new_user.password = 'namename'
    assert new_user.save
  end

  test "does not save with invalid email" do
    user = users(:iron)
    user.password = 'ironiron'
    user.email = 'nonvalidmail'
    assert_not user.save

    user.email = 'n@onvalidemail'
    assert_not user.save

    user.email = '@nonvalidemail'
    assert_not user.save

    user.email = 'iron@mail.com'
    assert user.save
  end

  test "does not save with password shorter than minimum (6) length" do
    user = users(:iron)
    user.password = 'ironi'
    assert_not user.save

    user.password = 'ironir'
    assert user.save

    user.password = 'ironiron'
    assert user.save
  end

  test "finds and authenticates valid user" do
    user = users(:iron)
    user.password = 'ironiron'
    user.save

    auth_params = { email: 'iron@dmm.com', password: 'ironiron'}
    auth_user = User.find_and_authenticate(auth_params)

    assert_not_nil auth_user
    assert_equal user, auth_user

  end

  test "does not find and authenticates invalid user" do
    auth_params = { email: 'nonuser@dmm.com', password: 'nonuser'}
    auth_user = User.find_and_authenticate(auth_params)

    assert_nil auth_user
  end

  test "does not authenticates valid user with non-matching password" do
    user = users(:iron)
    user.password = 'ironiron'
    user.save
    auth_params = { email: 'iron@dmm.com', password: 'unmatchingpass'}
    auth_user = User.find_and_authenticate(auth_params)

    assert_nil auth_user
  end

end
