class PageRoleAccess < ApplicationRecord
  belongs_to :page
  belongs_to :role
end
