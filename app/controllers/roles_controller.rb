# Should only be accessible to admin users
class RolesController < ApplicationController
  include AdminConstraint

  def index
    @roles = Role.all
  end

  def create
    Role.create(params[:role])
  end

  def show
    @role = Role.find(params[:id])
  end

  private
  def role_params
    params.require(:role).permit(:name)
  end
end
