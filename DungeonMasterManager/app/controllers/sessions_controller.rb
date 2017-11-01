class SessionsController < ApplicationController
  before_action :check_already_logged, only: [:new, :create]

  def new
  end

  def create
    if request.env["omniauth.auth"]
      @user = User.find_or_create(request.env["omniauth.auth"])
    else
      @user = User.find_and_authenticate(session_params)
    end

    if @user.nil?
      redirect_to login_path, flash: { error: 'Incorrect user/password combination provided' }
    else
	   login(@user)
	   redirect_to root_path, flash: { success: 'Greetings, %s!' % [@user.name] }
    end
  end

  def destroy
    @user = current_user
  	logout
  	redirect_to root_path, flash: { success: 'Goodbye, %s!' % [@user.name] } 
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

end
