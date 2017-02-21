FactoryGirl.define do
  factory :user do
    first_name        { Faker::Name.first_name }
    last_name         { Faker::Name.last_name }
    user_name         { Faker::Internet.user_name(4..20) }
    email             { Faker::Internet.email }
    password          'password123'
    avatar            { Faker::Avatar.image }
    group
    status            'status'
    confirmed         true
    reset_token       nil
    reset_at          nil
    sequence(:token)  { |i| "token#{i}" }
    bio               { Faker::Lorem.paragraph }
  end
end
