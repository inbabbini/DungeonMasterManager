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
    post logout_url
  end

  def login(email, password)
    post login_url, params: { session: { email: email, password: password } }
  end

  def create_user(name, email, password)
    post users_url, params: { user: { name: name, email: email, password: password, password_confirmation: password } }
    #User.create(name: name, email: email, password: password, password_confirmation: password)
  end
end
