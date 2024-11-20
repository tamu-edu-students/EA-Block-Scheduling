class Role < ApplicationRecord
  has_many :user_roles
  has_many :users, through: :user_roles
  has_many :page_role_accesses
  has_many :pages, through: :page_role_accesses
end
