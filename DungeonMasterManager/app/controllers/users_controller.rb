class UsersController < ApplicationController
  before_action :check_already_logged, only: [:new, :create]
  before_action :authenticate, except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
     @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to login_path, flash: { success: I18n.t 'flash_messages.success.user.registered', name: @user.name } }
        format.json { render :show, status: :created, location: @user }
      else
        flash.now[:error] = I18n.t 'flash_messages.error.form'
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        flash[:success] =
        format.html { redirect_to user_path(@user), flash: { success: I18n.t 'flash_messages.success.updated', model: I18n.t 'model.user' } }
        format.json { render :show, status: :ok, location: @user }
      else
        flash.now[:error] = I18n.t 'flash_messages.error.form'
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      logout
      format.html { redirect_to root_path, flash: { success: I18n.t 'flash_messages.success.user.deleted' } }
      format.json { head :no_content }
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :picture)
  end

  def set_user
    @user = current_user
  end

end
