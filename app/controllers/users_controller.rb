class UsersController < ApplicationController
  include ApplicationHelper

  def index
    if current_user.admin?
      @users = User.all
    else
      not_admin
    end
  end

  def show
    if current_user_admin?
      user_id = params[:id]
      @user = User.find(user_id)
    else
      not_admin
    end
  end

  def edit
    if current_user_admin?
      @user = User.find(params[:id])
    else
      not_admin
    end
  end

  def profile
    @user = User.find(current_user.id)
  end

  def update
    if current_user_admin?
      @user = User.find params[:id]
      @user.update!(user_params)
      flash[:notice] = "#{@user.email} was successfully updated."
      redirect_to user_path
    else
      not_admin
    end
  end

  private
  def not_admin
    redirect_to welcome_path, alert: "You are not authorized to perform this action."
  end
  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :role, :uid, :provider)
  end
end
