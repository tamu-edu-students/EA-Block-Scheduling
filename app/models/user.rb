class User < ApplicationRecord
  has_many :user_roles
  has_many :roles, through: :user_roles
  validates :email, presence: true

  after_create :assign_default_role

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

  private
  def assign_default_role
    user_role = UserRole.new
    user_role.user_id = self.id
    user_role.role_id = Role.find_by(name: "student").id
    user_role.save
  end
end
