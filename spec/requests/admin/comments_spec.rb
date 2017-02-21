require 'rails_helper'

RSpec.describe "Comments", type: :request do
  before(:each) do
    a = FactoryGirl.create :user, admin: true
    cookies['auth_token'] = a.token
  end
  describe "GET /admin/comments" do
    it "works! (now write some real specs)" do
      get admin_comments_path
      expect(response).to have_http_status(200)
    end
  end
end
