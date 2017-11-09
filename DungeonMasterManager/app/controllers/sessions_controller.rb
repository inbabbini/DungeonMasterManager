class SessionsController < ApplicationController
  before_action :check_already_logged, only: [:new, :create]
  before_action :authenticate, only: :destroy

  def new
  end

  def create
    if request.env["omniauth.auth"]
      @user = User.find_or_create(request.env["omniauth.auth"])
    else
      @user = User.find_and_authenticate(session_params)
    end

    if @user.nil?
      redirect_to login_path, flash: { error: I18n.t('flash_messages.error.authentication') }
    else
	   login(@user)
	   redirect_to root_path, flash: { success: I18n.t('flash_messages.success.authentication', name: @user.name) }
    end
  end

  def destroy
    @user = current_user
  	logout
  	redirect_to root_path, flash: { success: I18n.t('flash_messages.success.logout', name: @user.name) }
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

end
