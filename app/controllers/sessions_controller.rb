class SessionsController < ApplicationController
  # skip_before_action :require_login, only: [:omniauth]
  # skip_before_action :require_login, only: [:new, :create]

  def logout
    reset_session
    redirect_to pages_path, notice: "You are logged out."
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
      redirect_to pages_path, notice: "Welcome, #{@user.first_name}!"
    else
      redirect_to pages_path, alert: "Login failed."
    end
  end

  def create
    state = State.create!(token: generate_state_token, data: { user_id: current_user.id })
    redirect_to provider.auth_code.authorize_url(state: state.token)
  end
end
