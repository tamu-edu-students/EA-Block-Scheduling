# app/controllers/admin_controller.rb
class AdminController < ApplicationController
  def dashboard
    # Your dashboard logic here
  end

  private
  def authorize_admin
    unless current_user.admin?
      redirect_to root_path, alert: "Unauthorized access"
    end
  end
end
