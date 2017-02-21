require 'rails_helper'

RSpec.describe "admin/pages/edit", type: :view do
  before(:each) do
    @page = assign(:page, Page.create!(
      :title => "MyString",
      :content => "MyText",
      :cover => "MyString",
      :permalink => "MyString",
      :area => nil,
      :commentable => false,
      :properties => "",
      :position => 1,
      :user => nil,
      :publish => false
    ))
  end

  it "renders the edit page form" do
    render

    assert_select "form[action=?][method=?]", admin_page_path(@page), "post" do

      assert_select "input#page_title[name=?]", "page[title]"

      assert_select "textarea#page_content[name=?]", "page[content]"

      assert_select "input#page_cover[name=?]", "page[cover]"

      assert_select "input#page_permalink[name=?]", "page[permalink]"

      assert_select "select#page_area_id[name=?]", "page[area_id]"

      assert_select "input#page_commentable[name=?]", "page[commentable]"

      assert_select "input#page_publish[name=?]", "page[publish]"
    end
  end
end
