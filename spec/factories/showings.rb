FactoryBot.define do
  factory :showing do
    date Faker::Date.between(Date.new(2018, 4, 12), Date.new(2018, 4, 17))
    time '03:00 PM'
    capacity Faker::Number.between(50, 100)
    price Faker::Number.between(5, 15)
    movie
  end
end
