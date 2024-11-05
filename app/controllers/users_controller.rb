# Should only be accessible to admin users
class UsersController < ApplicationController
  def show
    @current_user = User.find(params[:id])
  end
end
