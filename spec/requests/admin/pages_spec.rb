require 'rails_helper'

RSpec.describe "Pages", type: :request do
  before(:each) do
    a = FactoryGirl.create :user, admin: true
    cookies['auth_token'] = a.token
  end
  describe "GET /admin/pages" do
    it "works! (now write some real specs)" do
      get admin_pages_path
      expect(response).to have_http_status(200)
    end
  end
end
