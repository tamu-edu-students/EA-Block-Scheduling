class WelcomeController < ApplicationController
  skip_before_action :require_login, only: [:index]
  def index
    if logged_in?
      if check_admin?
        redirect_to admin_dashboard_path, notice: "Welcome back!"
      else
        redirect_to students_dashboard_path, notice: "Welcome back!"
      end
      # redirect_to user_path(@current_user), notice: "Welcome, back!"
    end
  end
end
