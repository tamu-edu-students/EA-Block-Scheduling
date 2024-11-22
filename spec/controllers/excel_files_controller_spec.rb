require 'rails_helper'

RSpec.describe ExcelFilesController, type: :controller do
  let(:user) { User.create!(email: "test@example.com", first_name: "Test", last_name: "User", uid: "123456789", provider: "google_oauth2") }
  before do
    # Simulate logged-in user by setting session[:user_id]
    session[:user_id] = user.id
  end
  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new ExcelFile and processes it" do
        file = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.xlsx'), 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
        expect {
          post :create, params: { excel_file: { name: "Test File", file: file } }
        }.to change(ExcelFile, :count).by(1)

        expect(response).to redirect_to(ExcelFile.last)
        expect(flash[:notice]).to eq('Excel file was successfully uploaded and saved.')
      end
    end
  end

  describe 'POST #create' do
    context 'when the ExcelFile fails to save' do
      before do
        # Simulate a scenario where the ExcelFile is invalid
        allow_any_instance_of(ExcelFile).to receive(:save).and_return(false)
        allow_any_instance_of(ExcelFile).to receive(:errors).and_return({ name: ["can't be blank"] })
      end

      it 'does not save the ExcelFile' do
        expect do
          post :create, params: { excel_file: { name: '' } }
        end.not_to change(ExcelFile, :count)
      end

      it 'sets a flash notice indicating failure' do
        post :create, params: { excel_file: { name: '' } }
        expect(flash[:notice]).to eq("Courses not added to database.")
      end

      it 're-renders the new template with unprocessable entity status' do
        post :create, params: { excel_file: { name: '' } }
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns errors in JSON format when requested' do
        post :create, params: { excel_file: { name: '' } }, format: :json
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to include("name" => ["can't be blank"])
      end
    end
  end
end
