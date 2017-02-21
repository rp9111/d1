require 'rails_helper'

RSpec.describe "admin/pages/show", type: :view do
  before(:each) do
    @page = assign(:page, Page.create!(
      :title => "Title",
      :content => "MyText",
      :cover => "Cover",
      :permalink => "Permalink",
      :area => nil,
      :commentable => false,
      :properties => "",
      :position => 2,
      :user => nil,
      :publish => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Cover/)
    expect(rendered).to match(/Permalink/)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
  end
end
