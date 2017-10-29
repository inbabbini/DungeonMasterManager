class UsersController < ApplicationController
  before_action :authenticate, except: [:new, :create]

  #TODO: develop user creation and deletion logic

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
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
