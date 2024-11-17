class SessionsController < ApplicationController
  skip_before_action only: [:omniauth]

  def logout
    reset_session
    redirect_to welcome_path, notice: "You are logged out."
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
      if @user.role == "admin"
        redirect_to admin_dashboard_path, notice: "Welcome, Admin!"
      else
        redirect_to students_dashboard_path, notice: "Welcome, Student!"
      end
    else
      redirect_to welcome_path, alert: "Login failed."
    end
  end
end
