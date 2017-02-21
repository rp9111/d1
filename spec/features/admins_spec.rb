require 'rails_helper'

describe 'admin' do
  before(:each) do
    signed_in_admin
  end
  it 'lands on the dashboard' do
    expect(page.current_path).to eq admin_path
  end
end
