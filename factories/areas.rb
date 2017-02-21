FactoryGirl.define do
  factory :area do
    name        { Faker::Lorem.words(rand(9) + 1).join(' ').titleize }
    label       { Faker::Lorem.words(rand(2) + 1).join(' ').titleize }
    navigation  true
    footer      false
    comments    false
    position    1
    ascending   true
    mode        'parallax'
  end
end
