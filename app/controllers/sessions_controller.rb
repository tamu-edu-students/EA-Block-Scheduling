class SessionsController < ApplicationController
  skip_before_action only: [:omniauth]
  include ApplicationHelper

  def logout
    reset_session
    redirect_to pages_path, notice: "You are logged out."
  end

  def failure
    redirect_to pages_path
  end

  # GET /auth/google_oauth2/callback
  def omniauth
    auth = request.env["omniauth.auth"]
    @user = User.find_or_create_by(uid: auth["uid"], provider: auth["provider"]) do |u|
      u.email = auth["info"]["email"]
      names = auth["info"]["name"].split
      u.first_name = names[0]
      u.last_name = names[1..].join(" ")
    end

    if @user.valid?
      session[:user_id] = @user.id
      # Redirect based on user role
      if current_user_admin?
        redirect_to admin_dashboard_path
      else
        redirect_to students_dashboard_path
      end
    else
      redirect_to pages_path, alert: "Login failed."
    end
  end
end
