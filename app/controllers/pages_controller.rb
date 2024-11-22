# /app/controllers/pages_controller.rb

class PagesController < ApplicationController
  include ApplicationHelper

  def index
    @logged_in = check_user_status!
  end

  private
  def check_user_status!
    user_signed_in? ? true : false
  end
end
