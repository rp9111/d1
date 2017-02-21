require 'rails_helper'

RSpec.describe Page, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  it 'can be created' do
    page = FactoryGirl.create :page
    expect(page).to be_truthy
  end
end
