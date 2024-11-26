class User < ApplicationRecord
  has_many :user_roles
  has_many :roles, through: :user_roles
  validates :email, presence: true
  after_initialize :set_default_role, if: :new_record?

  def admin?
    has_role?("admin")
  end

  def student?
    has_role?("student")
  end

  def has_role?(role_name)
    roles.any? { |role| role.name == role_name }
  end

  private
  def set_default_role
    self.roles << Role.find_by(name: "student") if roles.empty?
  end
end
