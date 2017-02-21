FactoryGirl.define do
  factory :group do
    name  { Faker::Lorem.words(rand(2) + 1).join(' ').titleize }
    description  { Faker::Lorem.words(rand(10) + 1).join(' ') }
  end
end
