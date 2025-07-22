FactoryBot.define do
  factory :transaction do
    association :user
    association :charity
    amount { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
  end
end