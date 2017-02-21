require 'rails_helper'

RSpec.describe UploadsController, type: :controller do

  describe "GET #create" do
    it "returns http success" do
      pending
      get :create
      expect(response).to have_http_status(:success)
    end
  end

end
