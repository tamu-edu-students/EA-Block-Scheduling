class User < ApplicationRecord
  has_many :user_roles
  has_many :roles, through: :user_roles
  validates :email, presence: true

  def admin?
    role == "admin"
  end

  def has_role?(role_name)
    roles.any? { |role| role.name == role_name }
  end

  # Method to check if the user is a student
  def student?
    role == "student"
  end
end
