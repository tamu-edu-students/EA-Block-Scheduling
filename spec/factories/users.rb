# spec/factories/users.rb
FactoryBot.define do
  # factory :user do
  #   email { "user@example.com" }
  #   role { "student" }  # Default role
  # end

  # factory :admin, parent: :user do
  #   role { "admin" }  # Admin user has the role 'admin'
  # end

  factory :user do
    uid { "12345" }
    provider { "google_oauth2" }
    email { "admin@adminuser.com" }
    first_name { "Admin" }
    last_name { "User" }

    trait :admin do
      role { "admin" }
    end
  end
end
