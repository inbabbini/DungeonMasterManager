class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :user_is_dm?
  helper_method :user_signed_in?
  before_action :set_locale

  def logout
    session[:user_id] = nil
  end

  def login(user)
    session[:user_id] = user.id
  end

  def check_already_logged
    if user_signed_in?
      flash[:warning] = I18n.t('flash_messages.warning.already_signed')
      redirect_to root_path
    end
  end

  def authenticate
  	redirect_to :login unless user_signed_in?
  end

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    !!current_user
  end

  def user_is_dm?
    current_user == @game.dungeon_master
  end

  #Custom validation callbacks

  def user_owns_character_or_game?
    redirect_back fallback_location: games_url, flash: { warning: I18n.t('flash_messages.warning.not_allowed')  } unless current_user.owns?(@character) || current_user.owns?(@game)
  end

  def user_owns_game?
    redirect_back fallback_location: games_url, flash: { warning: I18n.t('flash_messages.warning.not_allowed') } unless current_user.owns?(@game)
  end

  def user_belongs_to_game?
    redirect_back fallback_location: games_url, flash: { warning: I18n.t('flash_messages.warning.not_allowed') } unless current_user.is_dm_or_player?(@game)
  end

  #Shared initializers

  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_character
    @character = Character.find(params[:character_id])
  end

  #Locale initializer
  def set_locale
      I18n.locale = session[:locale] || I18n.default_locale
    end
  end

end
