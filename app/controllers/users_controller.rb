class UsersController < ApplicationController
  include ApplicationHelper
  before_action :require_admin, only: [:index, :show, :edit, :update, :destroy]

  def index
    @users = User.includes(:roles).all
  end

  def show
    user_id = params[:id]
    @user = User.find(user_id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def profile
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find params[:id]
    if @user.update(user_params)
      redirect_to @user, notice: "#{@user.email} was successfully updated."
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: "#{@user.email} was successfully deleted."
  end

  private
  # Ignore Brakeman warning for role parameter, as it is conditionally permitted
  def user_params
<<<<<<< HEAD
    params.require(:user).permit(:email, :first_name, :last_name, :role) # brakeman: ignore PermitAttributes
=======
    params.require(:user).permit(:email, :first_name, :last_name, :uid, :provider, :role)
>>>>>>> parent of 21950ca (Adjust permitted params in user controller)
  end
end
