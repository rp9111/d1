require 'rails_helper'

RSpec.describe "Areas", type: :request do
  before(:each) do
    a = FactoryGirl.create :user, admin: true
    cookies['auth_token'] = a.token
  end
  describe "GET /admin/areas" do
    it "works! (now write some real specs)", js: true do
      get admin_areas_path
      expect(response).to have_http_status(200)
    end
  end
end
