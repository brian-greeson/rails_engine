FactoryBot.define do
  factory :transaction do
    invoice { nil }
    credit_card_number { "" }
    credit_card_expiration_date { "2020-05-16 19:25:52" }
    result { 1 }
  end
end
