FactoryBot.define do
  factory :merchant do
    name { Faker::Space.agency + " Store" }
  end
end
