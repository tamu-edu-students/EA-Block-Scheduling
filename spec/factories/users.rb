FactoryBot.define do
  factory :admin_user, class: User do
    email { Faker::Internet.email }
    password { 'password' }
    admin { true }
  end
end

