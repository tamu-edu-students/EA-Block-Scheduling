# app/controllers/admin_controller.rb
class AdminController < ApplicationController
  include AdminConstraint
  def dashboard
    # dashboard logic here
  end

  def index
  end

  private
end
