class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  helper_method :current_user
  helper_method :logged_in?

  def current_user
    @current_user = User.find(session[:uid])
  end

  def logged_in?
    session[:uid].present?
  end

end
