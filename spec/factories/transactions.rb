FactoryBot.define do
  factory :transaction do
    invoice { nil }
    credit_card_number { Faker::Number.number(digits: 16) }
    credit_card_expiration_date { Faker::Date.forward(days: 731) }
    result { 1 }
  end
end
