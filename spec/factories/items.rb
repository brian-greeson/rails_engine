FactoryBot.define do
  factory :item do
    id { "" }
    name { "MyString" }
    description { "MyString" }
    unit_price { "9.99" }
    merchant_id { nil }
  end
end
