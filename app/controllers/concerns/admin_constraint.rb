# /app/controllers/concerns/admin_constraint.rb

module AdminConstraint
  extend ActiveSupport::Concern
  included do
    before_action :authorize_admin
  end

  private
  def authorize_admin
    unless current_user.admin?
      redirect_to welcome_path, alert: "You are not authorized to perform this action."
    end
  end
end
