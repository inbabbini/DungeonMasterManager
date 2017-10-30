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
        flash[:success] = 'Wellcome, %s! You have successfully registered.' % [@user.name]
        format.html { redirect_to login_path }
        format.json { render :show, status: :created, location: @user }
      else
        flash.now[:error] = 'Hmm... There seems to be some errors.'
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
        flash[:success] = 'User information successfully updated!'
        format.html { redirect_to user_path(@user) }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      logout
      flash[:success] = 'You successfully deleted your user. Farewell!'
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = current_user
    @user.picture = 'Profiles/profile_default.jpg' if @user.picture.nil?
  end

end
