# spec/controllers/schedules_controller_spec.rb

require 'rails_helper'

RSpec.describe SchedulesController, type: :controller do
  include_context('omniauth_sign_in')
  describe "GET #generate_schedule" do
    it "returns a successful response" do
      get :generate_schedule
      expect(response).to have_http_status(:ok)
    end

    it "assigns courses instance variable" do
      get :generate_schedule
      expect(assigns(:courses)).not_to be_nil
      expect(assigns(:courses).size).to eq(3)
    end
  end
end
