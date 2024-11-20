# /app/controllers/pages_controller.rb

class PagesController < ApplicationController
  include ApplicationHelper
  before_action :check_user_status!

  def index
  end

  private
  def check_user_status!
    unless user_signed_in?
      redirect_to welcome_path, notice: "You must be logged in to access this section."
    end
  end

  def pages_params
    params.require(:page).permit(:url_path)
  end
end
