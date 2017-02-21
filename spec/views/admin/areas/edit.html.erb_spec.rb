require 'rails_helper'

RSpec.describe "admin/areas/edit", type: :view do
  before(:each) do
    @area = assign(:area, Area.create!(
      :name => "MyString",
      :label => "MyString",
      :navigation => false,
      :footer => false,
      :comments => false,
      :position => 1,
      :ascending => false,
      :mode => "MyString"
    ))
  end

  it "renders the edit area form" do
    render

    assert_select "form[action=?][method=?]", admin_area_path(@area), "post" do

      assert_select "input#area_name[name=?]", "area[name]"

      assert_select "input#area_label[name=?]", "area[label]"

      assert_select "input#area_navigation[name=?]", "area[navigation]"

      assert_select "input#area_footer[name=?]", "area[footer]"

      assert_select "input#area_comments[name=?]", "area[comments]"

      assert_select "input#area_ascending[name=?]", "area[ascending]"

      assert_select "select#area_mode[name=?]", "area[mode]"
    end
  end
end
