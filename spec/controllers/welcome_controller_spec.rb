require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  let(:admin_user) { create(:admin) }  # Use the :admin factory for an admin user
  let(:student_user) { create(:user, role: 'student') }  # Use :user factory with the role 'student'

  describe "GET #index" do
    context "when the user is logged in as an admin" do
      before do
        # Simulate a logged-in admin user by setting session[:user_id]
        session[:user_id] = admin_user.id
        get :index  # Simulate a GET request to the welcome page
      end

      it "redirects to the admin dashboard" do
        # Check if the user was redirected to the admin dashboard
        expect(response).to redirect_to(admin_dashboard_path)
      end

      it "sets the correct flash message" do
        # Check if the correct flash message is set
        expect(flash[:notice]).to eq("Welcome back!")
      end
    end

    context "when the user is logged in as a student" do
      before do
        # Simulate a logged-in student user by setting session[:user_id]
        session[:user_id] = student_user.id
        get :index  # Simulate a GET request to the welcome page
      end

      it "redirects to the students dashboard" do
        # Check if the user was redirected to the students dashboard
        expect(response).to redirect_to(students_dashboard_path)
      end

      it "sets the correct flash message" do
        # Check if the correct flash message is set
        expect(flash[:notice]).to eq("Welcome back!")
      end
    end

    context "when the user is not logged in" do
      before do
        get :index  # Simulate a GET request when not logged in
      end

      it "renders the welcome page" do
        # Check that the response renders the welcome page
        expect(response).to render_template(:index)
      end
    end
  end
end
