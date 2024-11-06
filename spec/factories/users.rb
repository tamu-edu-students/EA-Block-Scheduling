FactoryBot.define do
  factory :admin_user, class: User do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    uid { Faker::Internet.uuid }

    after(:create) do |user|
      user.add_role(:admin)
    end
  end
end

