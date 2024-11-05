class User < ApplicationRecord
  validates :email, presence: true
  has_many :user_roles
  has_many :roles, through: :user_roles

  def admin?
    role == "admin"
  end

  # Method to check if the user is a student
  def student?
    role == "student"
  end
end
