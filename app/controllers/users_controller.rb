class UsersController < ApplicationController
  include ApplicationHelper
  before_action :require_admin, only: [:index, :show, :edit, :update]

  def index
    @users = User.all
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

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :uid, :provider, :role)
  end
end
