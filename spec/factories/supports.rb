FactoryBot.define do
  factory :support do
    association :user
    association :charity
  end
end