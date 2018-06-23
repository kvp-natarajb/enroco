FactoryBot.define do
  factory :user do
    first_name    { Faker::Name.first_name }
    last_name     { Faker::Name.last_name }
    email         { Faker::Internet.email }
    password      { "Admin@123" }
    confirmed_at  { Time.now + 1.minutes }
  end
end