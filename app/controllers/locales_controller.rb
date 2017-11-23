class LocalesController < ApplicationController

  def change_locale
     if !locale_params[:locale_abbr].nil? && locale_params[:locale_abbr].in?(I18n.available_locales)
       session[:locale] = locale_params[:locale_abbr]
     end
     redirect_back fallback_location: home_path, flash: {notice: I18n.t('flash_messages.notice.locale_set_to', locale: locale_params[:locale_abbr])}

  end

  private

  def locale_params
    params.permit(:locale_abbr)
  end

end
