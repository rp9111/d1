require 'rails_helper'

RSpec.describe "admin/comments/index", type: :view do
  before(:each) do
    @user = User.create!(
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
    )
    @page = Page.create!(
      :title => "Title",
      :content => "MyText",
      :cover => "Cover",
      :permalink => "Permalink",
      :area => nil,
      :commentable => false,
      :properties => "",
      :position => 2,
      :user => nil,
      :publish => false
    )
    assign(:comments, [
      Comment.create!(
        :user => @user,
        :page => @page,
        :content => "MyText",
        :approved => false
      ),
      Comment.create!(
        :user => @user,
        :page => @page,
        :content => "MyText",
        :approved => false
      )
    ])
  end

  it "renders a list of comments" do
    render
    assert_select "tr>td", :text => @page.to_s, :count => 2
    assert_select "tr>td", :text => @user.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
