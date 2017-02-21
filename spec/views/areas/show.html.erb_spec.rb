require 'rails_helper'

RSpec.describe "areas/show", type: :view do
  before(:each) do
    @page = FactoryGirl.create :page
    @area = @page.area
    assign(:area, @area)
    assign(:pages, [@page])
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/#{@page.title}/)
    expect(rendered).to match(/#{simple_format(@page.content.gsub(/\n/, "\n\n"))}/)
  end
end
