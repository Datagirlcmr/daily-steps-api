FactoryBot.define do
  factory :measurement do
    steps_recorded { Faker::Number.number }
    step_id nil
  end
end