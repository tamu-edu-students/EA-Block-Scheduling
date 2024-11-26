class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  helper_method :current_user, :require_admin, :require_role


  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_role(role_name)
    unless current_user&.has_role?(role_name)
      redirect_to pages_path, alert: "You don't have the required role (#{role_name}) to access this page."
    end
  end

  def require_admin
    unless current_user&.admin?
      redirect_to pages_path, alert: "You don't have access to this page."
    end
  end
end
