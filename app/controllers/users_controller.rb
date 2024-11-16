# Should only be accessible to admin users
class UsersController < ApplicationController
  include AdminConstraint
  before_action :authenticate_user!
  # before_action :authorize_admin, only: [:index, :destroy]
  def index
    if current_user.admin?
      @users = User.all
    else
      @users = User.where(id: current_user.id)
    end
  end

  def destroy
    @user.destroy if current_user.admin?
  end
  def show
    @current_user = set_user
  end

  private
  def current_user_admin?
    current_user.roles.any? { |role| role.name == "admin" }
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :uid, :provider)
  end
end
