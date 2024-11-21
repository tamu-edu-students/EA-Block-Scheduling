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
        expect(response).to redirect_to(pages_path)
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
        expect(page).to have_text("Howdy")
      end
    end

    context "when the user is invalid" do
      before do
        invalid_user = build_stubbed(:user)
        allow(invalid_user).to receive(:valid?).and_return(false)
        allow(User).to receive(:find_or_create_by).and_return(invalid_user)
        get :omniauth
      end

      it "redirects to the home page" do
        expect(response).to redirect_to(pages_path)
      end

      it "sets an alert message" do
        expect(page).to have_text("Please sign in to access services")
      end
    end
  end

  let(:admin_user) { create(:admin) }  # Use the :admin factory for an admin user
  let(:student_user) { create(:user, role: 'student') }  # Use :user factory with the role 'student'

  describe "GET #admin_dashboard" do
    context "when the user is logged in as an admin" do
      before do
        session[:user_id] = admin_user.id  # Simulate logged-in admin user
        get :dashboard  # Perform GET request to the dashboard
      end

      it "returns a successful response" do
        expect(response).to have_http_status(:success)
      end
    end

    context "when the user is logged in as a student" do
      before do
        session[:user_id] = student_user.id  # Simulate logged-in student user
        get :dashboard  # Perform GET request to the dashboard
      end

      it "returns a successful response" do
        expect(response).to have_http_status(:success)
      end
    end

    context "when the user is not logged in" do
      before do
        get :dashboard  # Perform GET request without a logged-in user
      end

      it "redirects to the welcome page" do
        expect(response).to redirect_to(pages_path)
      end

      it "sets an alert message" do
        expect(flash[:alert]).to eq("You must be logged in to access this section.")
      end
    end
  end
end
