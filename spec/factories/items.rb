FactoryBot.define do
  factory :item do
    name { Faker::Vehicle.make_and_model }
    description { Faker::Vehicle.car_options }
    unit_price { Faker::Number.decimal(l_digits: 5, r_digits: 2) }
    merchant_id { nil }
  end
end
