require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/sessions/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/sessions/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /sso_new" do
    it "returns http success" do
      get "/sessions/sso_new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /sso_create" do
    it "returns http success" do
      get "/sessions/sso_create"
      expect(response).to have_http_status(:success)
    end
  end
end

