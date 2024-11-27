# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user0) { User.create!(email: "test@example.com", first_name: "Test", last_name: "User", role: "admin", uid: "123456789", provider: "google_oauth2") }
  let(:user2) { User.create!(email: "test2@example.com", first_name: "Test2", last_name: "User2", uid: "123456780", provider: "google_oauth2") }
  let(:user3) { User.create!(email: "test3@example.com", first_name: "Test3", last_name: "User3", uid: "123456782", provider: "google_oauth2") }
  let(:user4) { User.create!(email: "test4@example.com", first_name: "Test4", last_name: "User4", uid: "123456781", provider: "google_oauth2") }

  # Helper to simulate login via OmniAuth
  def simulate_login(user)
    request.env["omniauth.auth"] = {
      "uid" => user.uid,
      "provider" => user.provider,
      "info" => {
        "email" => user.email,
        "first_name" => user.first_name,
        "last_name" => user.last_name
      }
    }
    session[:user_id] = user.id
  end

  before do
    # Simulate logged-in user by setting session[:user_id]
    session[:user_id] = user0.id
  end

  describe 'GET #profile' do
    let(:user) { User.create!(email: "test.mctest@example.com", first_name: "Test", last_name: "User", role: "admin", uid: "123456789", provider: "google_oauth2") }

    before do
      simulate_login(user)  # Simulate the login here using OmniAuth mock
    end

    it 'assigns the current user to @user' do
      get :profile
      expect(assigns(:user)).to eq(user)
    end

    it 'renders the profile template' do
      get :profile
      expect(response).to render_template(:profile)
    end

    it 'responds successfully with HTTP 200' do
      get :profile
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #index" do
    let(:admin_user) { create(:user, role: "admin") }
    let(:regular_user) { create(:user) }

    context "with admin user rights" do
      before do
        simulate_login(admin_user)  # Simulate login for admin user
      end

      it 'returns a successful response' do
        get :index
        expect(response).to be_successful
      end
    end

    context "with normal user rights" do
      before do
        simulate_login(regular_user)  # Simulate login for regular user
      end

      it "returns message and redirects to root path" do
        get :index
        expect(response).to redirect_to(root_path + "login")
        expect(flash[:alert]).to eq("You don't have access to this page.")
      end
    end
  end

  describe "GET #edit" do
    it "renders the edit template" do
      get :edit, params: { id: user0.id }
      expect(response).to render_template(:edit)
    end

    it "assigns the correct user to @user" do
      get :edit, params: { id: user0.id }
      expect(assigns(:user)).to eq(user0)
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do
      it "updates the user and redirects to the user's profile" do
        patch :update, params: { id: user0.id, user: { first_name: "NewName" } }
        user0.reload
        expect(user0.first_name).to eq("NewName")
        expect(response).to redirect_to(user0)
      end
    end
  end

  describe "GET #show" do
    it "renders the show template" do
      get :show, params: { id: user0.id }
      expect(response).to render_template(:show)
    end

    it "assigns the correct user to @user" do
      get :show, params: { id: user0.id }
      expect(assigns(:user)).to eq(user0)
    end
  end

  describe "DELETE #destroy" do
    let!(:user) { create(:user, email: "test99@example.com") } # Create a test user

    it "deletes the user" do
      expect {
        delete :destroy, params: { id: user.id }
      }.to change(User, :count).by(-1) # Ensure the user is deleted
    end

    it "sets a flash notice" do
      delete :destroy, params: { id: user.id }
      expect(flash[:notice]).to eq("test99@example.com was successfully deleted.") # Verify the flash message
    end

    it "redirects to the users index" do
      delete :destroy, params: { id: user.id }
      expect(response).to redirect_to(users_path) # Ensure redirection to the index
    end

    context "when the user is not found" do
      it "raises an ActiveRecord::RecordNotFound error" do
        expect {
          delete :destroy, params: { id: 9999 } # Non-existent user ID
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
