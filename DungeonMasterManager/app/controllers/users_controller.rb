class UsersController < ApplicationController
  before_action :authenticate, except: [:new, :create]

  #TODO: develop user creation and deletion logic

  def show
  end

  def new
     @user = User.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
