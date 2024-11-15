class User < ApplicationRecord
  has_many :user_roles
  has_many :roles, through: :user_roles
  validates :email, presence: true
  def admin?
    role == "admin"
  end

  # Method to check if the user is a student
  def student?
    role == "student"
  end
end
