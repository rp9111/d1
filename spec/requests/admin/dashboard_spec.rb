require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
  before(:each) do
    a = FactoryGirl.create :user, admin: true
    cookies['auth_token'] = a.token
  end
  describe "GET /" do
    it "works even without any pages define" do
      get admin_path
      expect(response).to have_http_status(200)
    end
    it "has a create page link" do
      get admin_path
      expect(response.body).to have_link('here')
    end
  end
end
