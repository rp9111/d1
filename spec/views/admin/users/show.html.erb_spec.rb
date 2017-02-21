require 'rails_helper'

RSpec.describe "admin/users/show", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :first_name => "First Name",
      :last_name => "Last Name",
      :user_name => "User Name",
      :email => "E@Mail.com",
      :password_digest => "Password Digest",
      :avatar => "Avatar",
      :status => "Status",
      :confirmed => false,
      :token => "Token",
      :reset_token => "Reset Token",
      :bio => "MyText",
      :preferences => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/user_name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Password Digest/)
    expect(rendered).to match(/Avatar/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Token/)
    expect(rendered).to match(/Reset Token/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
