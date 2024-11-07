class User < ApplicationRecord
  validates :email, presence: true
  has_many :user_roles
  has_many :roles, through: :user_roles

  def admin?
    self.roles.include?(Role.find_by(name: "admin"))
  end

  def add_role_to_user(role_name)
    role = Role.find_or_create_by(name: role_name)
    user_roles.create(role_id: role.id)
  end
end
