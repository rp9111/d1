require 'rails_helper'

RSpec.describe "admin/comments/edit", type: :view do
  before(:each) do
    @comment = assign(:comment, Comment.create!(
      :user => nil,
      :page => nil,
      :content => "MyText",
      :approved => false
    ))
  end

  it "renders the edit comment form" do
    render

    assert_select "form[action=?][method=?]", admin_comment_path(@comment), "post" do

      assert_select "input#comment_user_id[name=?]", "comment[user_id]"

      assert_select "input#comment_page_id[name=?]", "comment[page_id]"

      assert_select "textarea#comment_content[name=?]", "comment[content]"

      assert_select "input#comment_approved[name=?]", "comment[approved]"
    end
  end
end
