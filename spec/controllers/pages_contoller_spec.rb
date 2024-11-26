require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe '#check_user_status!' do
    context 'when user is signed in' do
      it 'returns nil (implicitly, since false is not returned)' do
        allow(controller).to receive(:user_signed_in?).and_return(true)
        result = controller.send(:check_user_status!)  # calling private method using send
        expect(result).to be_truthy
      end
    end

    context 'when user is not signed in' do
      it 'returns false' do
        allow(controller).to receive(:user_signed_in?).and_return(false)
        result = controller.send(:check_user_status!)  # calling private method using send
        expect(result).to eq(false)
      end
    end
  end

  describe 'GET #index' do
    context 'when user is signed in' do
      before do
        allow(controller).to receive(:user_signed_in?).and_return(true)  # Simulate user being signed in
        get :index
      end

      it 'sets @logged_in to true' do
        expect(assigns(:logged_in)).to eq(true)
      end
    end

    context 'when user is not signed in' do
      before do
        allow(controller).to receive(:user_signed_in?).and_return(false)  # Simulate user not being signed in
        get :index
      end

      it 'sets @logged_in to false' do
        expect(assigns(:logged_in)).to eq(false)
      end
    end
  end

  describe "GET #dashboard" do
    let(:admin_user) { create(:user) }  # Use the :admin factory for an admin user
    let(:student_user) { create(:user, role: 'student') }  # Use :user factory with the role 'student'
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
  end
end
