FactoryBot.define do
  factory :movie do
    title { Faker::Book.title }
  end
end
