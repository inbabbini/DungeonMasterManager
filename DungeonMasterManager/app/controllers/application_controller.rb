class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :user_is_dm?
  helper_method :user_signed_in?

  def authenticate
  	redirect_to :login unless user_signed_in?
  end

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
  	# converts current_user to a boolean by negating the negation
  	!!current_user
  end

  def user_is_dm?
    return current_user == @game.dungeon_master
  end

  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_character
    @character = Character.find(params[:character_id])
  end
  
end
