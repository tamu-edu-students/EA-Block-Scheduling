require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "POST #logout" do
    context "when the user logs out" do
      before do
        allow(controller).to receive(:current_user).and_return(build_stubbed(:user))
        session[:user_id] = 1  # Simulate a logged-in user
        post :logout
      end

      it "resets the session" do
        expect(session[:user_id]).to be_nil
      end

      it "redirects to the welcome page" do
        expect(response).to redirect_to(welcome_path)
      end

      it "sets a notice message" do
        expect(flash[:notice]).to eq("You are logged out.")
      end
    end
  end

  describe "GET #omniauth" do
    let(:auth_hash) do
      {
        "provider" => "google_oauth2",
        "uid" => "12345",
        "info" => {
          "email" => "user@example.com",
          "name" => "John Doe"
        }
      }
    end

    before do
      request.env["omniauth.auth"] = auth_hash
    end

    context "when the user is valid" do
      before do
        allow(User).to receive(:find_or_create_by).and_return(
          build_stubbed(:user, role: "admin", id: 1)
        )
        get :omniauth
      end

      it "sets the session user_id" do
        expect(session[:user_id]).to eq(1)
      end

      it "redirects to the admin dashboard for an admin user" do
        expect(response).to redirect_to(admin_dashboard_path)
        expect(flash[:notice]).to eq("Welcome, Admin!")
      end
    end

    context "when the user is invalid" do
      before do
        invalid_user = build_stubbed(:user)
        allow(invalid_user).to receive(:valid?).and_return(false)
        allow(User).to receive(:find_or_create_by).and_return(invalid_user)
        get :omniauth
      end

      it "redirects to the welcome page" do
        expect(response).to redirect_to(welcome_path)
      end

      it "sets an alert message" do
        expect(flash[:alert]).to eq("Login failed.")
      end
    end
  end
end
