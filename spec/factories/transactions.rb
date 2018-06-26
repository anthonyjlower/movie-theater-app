FactoryBot.define do
  factory :transaction do
    quantity Faker::Number.between(1, 3)
    email Faker::Internet.email
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    cost Faker::Number.between(10, 50)
    showing
  end
end
