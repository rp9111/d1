require 'rails_helper'

RSpec.describe "Admin", type: :request do
  before(:each) do
    a = signed_in_admin
    cookies['auth_token'] = a.token
  end
  describe "GET /admin" do
    it "works", js: true do
      get admin_path
      expect(response).to have_http_status(200)
    end
  end
end
