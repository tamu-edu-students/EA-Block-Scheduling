# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    email { "user@example.com" }
    role { "student" }  # Default role
  end

  factory :admin, parent: :user do
    role { "admin" }  # Admin user has the role 'admin'
  end
end
