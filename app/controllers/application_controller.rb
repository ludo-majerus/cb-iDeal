class ApplicationController < ActionController::Base
	protect_from_forgery

	before_filter :set_locale


  def require_login
    if session[:current_user_authenticated].nil? 
      flash[:error] = t(:access_restricted)
      redirect_to new_session_path, :status => 302
    end
  end

  def set_locale
		I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
		session[:locale] = I18n.locale
	end

end
