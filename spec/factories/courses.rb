FactoryBot.define do
  factory :course do
    sequence(:sec_name) { |n| "CSCE #{n}-001" }
    days { "MW" }
    start_time { "9:00 AM" }
    end_time { "10:20 AM" }
    building { "HLC1" }
    room { "2101" }
    category { "Engineering" }

    trait :math do
      sec_name { "MATH-2413-001" }
      category { "Math" }
      prerequisites { "MATH-2412" }
    end

    trait :science do
      sec_name { "PHYS-2425-001" }
      category { "Science" }
      prerequisites { "MATH-2413" }
    end

    trait :with_prerequisites do
      prerequisites { "MATH-2412" }
    end

    trait :without_prerequisites do
      prerequisites { nil }
    end
  end
end
