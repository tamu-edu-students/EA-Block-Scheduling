# Should only be accessible to admin users
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin, only: [:index, :destroy]
  def index
    @users = User.all
  end

  def destroy
    @user.destroy
  end
  def show
    @current_user = set_user
  end

  private
  def authorize_admin
    unless current_user.admin?
      redirect_to root_path, alert: "Unauthorized access"
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :uid, :provider)
  end
end
