require 'rails_helper'

RSpec.describe AdminController, type: :controller do
  let(:admin_user) { create(:admin) }  # Use the :admin factory for an admin user
  let(:student_user) { create(:user, role: 'student') }  # Use :user factory with the role 'student'

  describe "GET #dashboard" do
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

      it "returns a successful response (but test actual behavior as needed)" do
        expect(response).to have_http_status(:success)
      end
    end

    context "when the user is not logged in" do
      before do
        get :dashboard  # Perform GET request without a logged-in user
      end

      it "redirects to the welcome page" do
        expect(response).to redirect_to(welcome_path)
      end

      it "sets an alert message" do
        expect(flash[:alert]).to eq("You must be logged in to access this section.")
      end
    end
  end
end
