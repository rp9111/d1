require 'rails_helper'

RSpec.describe "admin/areas/show", type: :view do
  before(:each) do
    @area = assign(:area, Area.create!(
      :name => "Name",
      :label => "Label",
      :navigation => false,
      :footer => false,
      :comments => false,
      :position => 2,
      :ascending => false,
      :mode => "Mode"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Label/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Mode/)
  end
end
