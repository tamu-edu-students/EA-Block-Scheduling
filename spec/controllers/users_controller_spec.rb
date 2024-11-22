# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user0) { User.create!(email: "test@example.com", first_name: "Test", last_name: "User", role: "admin", uid: "123456789", provider: "google_oauth2") }
  let(:user2) { User.create!(email: "test2@example.com", first_name: "Test2", last_name: "User2", uid: "123456780", provider: "google_oauth2") }
  let(:user3) { User.create!(email: "test3@example.com", first_name: "Test3", last_name: "User3", uid: "123456782", provider: "google_oauth2") }
  let(:user4) { User.create!(email: "test4@example.com", first_name: "Test4", last_name: "User4", uid: "123456781", provider: "google_oauth2") }

  before do
    # Simulate logged-in user by setting session[:user_id]
    session[:user_id] = user0.id
  end

  describe 'GET #profile' do
    let(:user) { User.create!(email: "test.mctest@example.com", first_name: "Test", last_name: "User", role: "admin", uid: "123456789", provider: "google_oauth2") }

    before do
      # Simulate a logged-in user
      allow(controller).to receive(:current_user).and_return(user)
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
      before { session[:user_id] = admin_user.id }
      it 'returns a successful response' do
        get :index
        expect(response).to be_successful
      end
    end

    context "with normal user rights" do
      before { session[:user_id] = regular_user.id }
      it "returns message and redirects to root path" do
        get :index
        expect(response).to redirect_to(pages_path)
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
end
