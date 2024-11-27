class User < ApplicationRecord
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles
  validates :email, presence: true

  def admin?
    role == "admin"
  end

  def has_role?(role_name)
    roles.any? { |role| role.name == role_name }
  end

  def assign_role(role_name)
    role = Role.find_by(name: role_name)
    roles << role if role && !roles.include?(role)
  end

  def remove_role(role_name)
    role = Role.find_by(name: role_name)
    roles.delete(role) if role && roles.include?(role)
  end

  def is_admin?
    has_role?("admin")
  end

  def is_student?
    has_role?("student")
  end

  # Method to check if the user is a student
  def student?
    role == "student"
  end
end
