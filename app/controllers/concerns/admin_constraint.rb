# app/controllers/concerns/admin_constraint.rb

module AdminConstraint
  extend ActiveSupport::Concern

  included do
    before_action :authorize_admin
  end

  private
  def authorize_admin
    unless current_user.admin?
      redirect_to root_path, alert: 'User not authorized to view content'
    end
  end
end
