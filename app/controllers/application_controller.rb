class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  helper_method :current_user


  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_admin
    unless current_user&.admin?
      redirect_to pages_path, alert: "You don't have access to this page."
    end
  end
end
