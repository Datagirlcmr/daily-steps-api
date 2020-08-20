FactoryBot.define do
  factory :step do
    title { Faker::Lorem.word }
    day_recorded { Faker::Business.credit_card_expiry_date }
  end
end
