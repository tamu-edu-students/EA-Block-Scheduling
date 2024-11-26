# app/controllers/admin_controller.rb
class AdminController < ApplicationController
  before_action :require_admin

  def dashboard
    # dashboard logic here
  end

  private
end
