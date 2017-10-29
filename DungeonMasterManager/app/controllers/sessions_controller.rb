class SessionsController < ApplicationController

  def new
  end

  def create
    if request.env["omniauth.auth"]
      @user = User.find_or_create(request.env["omniauth.auth"])
    else
      @user = User.find_and_authenticate(session_params)
    end

    if @user.nil?
      redirect_to login_path, notice: 'Incorrect user/password combination provided'
    else
	   session[:user_id] = @user.id
	   redirect_to root_path, notice: 'Greetings, ' + current_user.name + '!'
    end
  end

  def destroy
    @user = current_user
  	session[:user_id] = nil
  	redirect_to root_path, notice: 'Farewell, ' + @user.name
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

end
