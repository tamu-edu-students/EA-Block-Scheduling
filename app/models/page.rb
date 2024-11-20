class Page < ApplicationRecord
  has_many :page_role_accesses
  has_many :roles, through: :page_role_accesses

  def access_level?(role_name)
    roles.any? { |role| role.name == role_name }
  end
end
