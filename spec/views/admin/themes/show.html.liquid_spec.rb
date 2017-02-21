require 'rails_helper'

RSpec.describe "admin/themes/show", type: :view do
  before(:each) do
    @admin_theme = assign(:admin_theme, Admin::Theme.create!(
      :name => "Name",
      :structure => "MyText",
      :style => "MyText",
      :behavior => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
