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
    @roles = Role.all # Load all roles for the form
  end

  def profile
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      if params[:user][:role_ids]
        update_user_roles
      end
      redirect_to @user, notice: "#{@user.email} was successfully updated."
    else
      flash[:error] = "Failed to update user."
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: "#{@user.email} was successfully deleted."
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :uid, :provider, role_ids: [])
  end

  def update_user_roles
    # Step 1: Remove all existing user_roles for the user
    @user.user_roles.destroy_all

    # Step 2: Add new user_roles based on the selected role_ids
    if params[:user][:role_ids].present?
      params[:user][:role_ids].each do |role_id|
        @user.user_roles.create(role_id: role_id)
      end
    end
  end
end
