class User < ApplicationRecord
  validates :email, presence: true
  def admin?
    role == "admin"
  end

  # Method to check if the user is a student
  def student?
    role == "student"
  end
end
