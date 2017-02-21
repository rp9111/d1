require 'rails_helper'

RSpec.describe "admin/themes/index", type: :view do
  before(:each) do
    assign(:admin_themes, [
      Admin::Theme.create!(
        :name => "Name",
        :structure => "MyText",
        :style => "MyText",
        :behavior => "MyText"
      ),
      Admin::Theme.create!(
        :name => "Name",
        :structure => "MyText",
        :style => "MyText",
        :behavior => "MyText"
      )
    ])
  end

  it "renders a list of admin/themes" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
