require 'rails_helper'

RSpec.describe "admin/areas/index", type: :view do
  before(:each) do
    assign(:areas, [
      Area.create!(
        name: "TheName",
        label: "TheLabel",
        navigation: true,
        footer: false,
        comments: false,
        position: 2,
        ascending: false,
        mode: Area::LAYOUTS.first[1]
      ),
      Area.create!(
        name: "TheName",
        label: "TheLabel",
        navigation: true,
        footer: false,
        comments: false,
        position: 2,
        ascending: false,
        mode: Area::LAYOUTS.first[1]
      )
    ])
  end

  it "renders a list of areas" do
    render

    assert_select "tr>td", text: "TheName", count: 2
    assert_select "tr>td", text: "Yes", count: 2
    assert_select "tr>td", text: "No", count: 2
    assert_select "tr>td", text: "TheLabel", count: 2
    assert_select "tr>td", text: "Off", count: 2
    assert_select "tr>td", text:  Area::LAYOUTS.first[0], count: 2
  end
end
