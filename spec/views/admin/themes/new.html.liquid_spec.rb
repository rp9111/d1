require 'rails_helper'

RSpec.describe "admin/themes/new", type: :view do
  before(:each) do
    assign(:admin_theme, Admin::Theme.new(
      :name => "MyString",
      :structure => "MyText",
      :style => "MyText",
      :behavior => "MyText"
    ))
  end

  it "renders new admin_theme form" do
    render

    assert_select "form[action=?][method=?]", admin_themes_path, "post" do

      assert_select "input#admin_theme_name[name=?]", "admin_theme[name]"

      assert_select "textarea#admin_theme_structure[name=?]", "admin_theme[structure]"

      assert_select "textarea#admin_theme_style[name=?]", "admin_theme[style]"

      assert_select "textarea#admin_theme_behavior[name=?]", "admin_theme[behavior]"
    end
  end
end
