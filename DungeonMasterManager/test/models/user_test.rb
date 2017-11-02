require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

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

    user.email = 'valid@mail.com'
    assert user.save
  end

  test "save with valid email" do
    skip
  end

  test "save with password shorter than minimum (6) length" do
    skip
  end

  test "save with password equal or longer than minimum (6) length" do
    skip
  end

  test "finds and authenticates valid user" do
    skip
  end

  test "does not find and authenticates invalid user" do
    skip
  end

  test "does not authenticates valid user with non-matching password" do
    skip
  end

end
