FactoryGirl.define do
  factory :comment do
    user
    page
    content       { Faker::Lorem.sentences(rand(3) + 1).join(' ') }
    submitted_at  { 2.minutes.ago }
    approved      true
    posted_at     { 1.minute.ago }
  end
end
