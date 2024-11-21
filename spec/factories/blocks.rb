FactoryBot.define do
  factory :block do
    after(:build) do |block|
      block.courses << create(:course, category: 'Science')
      block.courses << create(:course, category: 'Math')
      block.courses << create(:course, category: 'Engineering')
      block.courses << create(:course, category: 'Other')
    end
  end
end
