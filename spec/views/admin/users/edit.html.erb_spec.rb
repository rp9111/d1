require 'rails_helper'

RSpec.describe "admin/users/edit", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :first_name => "MyString",
      :last_name => "MyString",
      :user_name => "MyString",
      :email => "E@Mail.com",
      :password_digest => "MyString",
      :avatar => "MyString",
      :status => "MyString",
      :confirmed => false,
      :token => "MyString",
      :reset_token => "MyString",
      :bio => "MyText",
      :preferences => ""
    ))
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", admin_user_path(@user), "post" do

      assert_select "input#user_first_name[name=?]", "user[first_name]"

      assert_select "input#user_last_name[name=?]", "user[last_name]"

      assert_select "input#user_user_name[name=?]", "user[user_name]"

      assert_select "input#user_email[name=?]", "user[email]"

      assert_select "input#user_avatar[name=?]", "user[avatar]"

      assert_select "input#user_status[name=?]", "user[status]"

      assert_select "input#user_confirmed[name=?]", "user[confirmed]"

      assert_select "textarea#user_bio[name=?]", "user[bio]"
    end
  end
end
