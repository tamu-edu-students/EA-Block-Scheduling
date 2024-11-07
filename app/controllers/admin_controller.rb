# app/controllers/admin_controller.rb
class AdminController < ApplicationController
  include AdminConstraint
  def dashboard
    # dashboard logic here
  end

  private
end
