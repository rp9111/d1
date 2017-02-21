require 'rails_helper'

RSpec.describe "admin/comments/new", type: :view do
  before(:each) do
    assign(:comment, Comment.new(
      :user => nil,
      :page => nil,
      :content => "MyText",
      :approved => false
    ))
  end

  it "renders new comment form" do
    render

    assert_select "form[action=?][method=?]", admin_comments_path, "post" do

      assert_select "input#comment_user_id[name=?]", "comment[user_id]"

      assert_select "input#comment_page_id[name=?]", "comment[page_id]"

      assert_select "textarea#comment_content[name=?]", "comment[content]"

      assert_select "input#comment_approved[name=?]", "comment[approved]"
    end
  end
end
