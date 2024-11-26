# /app/controllers/pages_controller.rb

class PagesController < ApplicationController
  include ApplicationHelper
  before_action :require_admin, only: [:admin_settings]

  def index
    @logged_in = check_user_status!
  end

  def dashboard
  end

  def admin_settings
  end

  private
  def check_user_status!
    user_signed_in? ? true : false
  end
end
