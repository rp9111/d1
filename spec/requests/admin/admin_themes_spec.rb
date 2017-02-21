require 'rails_helper'

RSpec.describe "Admin::Themes", type: :request do
  describe "GET /admin_themes" do
    it "works! (now write some real specs)" do
      get admin_themes_path
      expect(response).to have_http_status(200)
    end
  end
end
