FactoryBot.define do
  factory :invoice_item do
    item { nil }
    invoice { nil }
    quantity { 1 }
    unit_price { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
  end
end
