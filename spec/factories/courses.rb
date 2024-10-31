FactoryBot.define do
  factory :course do
    term { '224F000' }
    dept_code { 'MATH' }
    sec_name { 'MATH-2413-001' }
    short_title { 'Calculus I' }
    days { 'MW' }
    start_time { '9:00 AM' }
    end_time { '10:20 AM' }
    prerequisites { 'MATH-2412' }
  end
end
