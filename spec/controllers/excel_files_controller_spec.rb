require 'rails_helper'

RSpec.describe ExcelFilesController, type: :controller do
  let(:user) { User.create!(email: "test@example.com", first_name: "Test", last_name: "User", uid: "123456789", provider: "google_oauth2") }
  before do
    # Simulate logged-in user by setting session[:user_id]
    session[:user_id] = user.id
  end
  describe "POST #create" do
    let(:file) { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'valid_excel_file_Spring_2025.xlsx'), 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet') }
    context "with valid parameters" do
      it "creates a new ExcelFile and processes it" do
        expect {
          post :create, params: { excel_file: { name: "Test File", file: file } }
        }.to change(ExcelFile, :count).by(1)

        expect(response).to redirect_to(ExcelFile.last)
        expect(flash[:notice]).to eq('Excel file was successfully uploaded and saved.')
      end
    end
  end
end
