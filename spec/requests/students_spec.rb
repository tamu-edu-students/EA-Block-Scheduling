require 'rails_helper'

RSpec.describe "Students", type: :request do
  describe "GET /dashboard" do
    it "returns http success" do
      get "/students/dashboard"
      expect(response).to have_http_status(:success)
    end
  end

end
