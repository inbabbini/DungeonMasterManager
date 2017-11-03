require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def get_salt
    @salt ||= BCrypt::Engine.generate_salt
  end

  def encrypt_password password, salt
    BCrypt::Engine.hash_secret(login_password, get_salt)
  end

  def logout
    session[:user_id] = nil
  end

  def login(user)
    session[:user_id] = user.id
  end
end
