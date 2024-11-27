class Role < ApplicationRecord
  has_many :user_roles
  has_many :users, through: :user_roles

  attribute :role_type, :integer

  validates :name, presence: true
end
