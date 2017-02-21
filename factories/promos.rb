FactoryGirl.define do
  factory :promo do
    name "MyString"
    passthrough_url "MyString"
    stripe_coupon "MyString"
    hits 1
    enabled false
  end
end
