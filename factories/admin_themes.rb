FactoryGirl.define do
  factory :admin_theme, class: 'Admin::Theme' do
    name "MyString"
    structure "MyText"
    style "MyText"
    behavior "MyText"
  end
end
