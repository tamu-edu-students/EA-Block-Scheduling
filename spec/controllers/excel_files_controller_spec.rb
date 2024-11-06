require 'rails_helper'

RSpec.describe ExcelFilesController, type: :controller do
  include_context('omniauth_sign_in')

  let(:valid_attributes) do
    {
      name: "Test File",
      file: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'valid_excel_file_Spring_2025.xlsx'), 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
    }
  end

  let(:invalid_attributes) do
    {
      name: "",
      file: nil
    }
  end

  describe "PUT #update" do
    let(:excel_file) { ExcelFile.create! valid_attributes }

    context "with valid params" do
      let(:new_attributes) do
        {
          name: "Updated Test File"
        }
      end

      it "updates the requested excel_file" do
        put :update, params: { id: excel_file.to_param, excel_file: new_attributes }
        excel_file.reload
        expect(excel_file.name).to eq("Updated Test File")
      end

      context "with invalid params" do
        it "returns an unprocessable entity response (html)" do
          put :update, params: { id: excel_file.to_param, excel_file: invalid_attributes }
          expect(response).to render_template(:edit)
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it "returns an unprocessable entity response (json)" do
          put :update, params: { id: excel_file.to_param, excel_file: invalid_attributes, format: :json }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to include("application/json")
        end
      end
    end

    describe "DELETE #destroy" do
      let!(:excel_file) { ExcelFile.create! valid_attributes }

      it "destroys the requested excel_file" do
        expect {
          delete :destroy, params: { id: excel_file.to_param }
        }.to change(ExcelFile, :count).by(-1)
      end

      it "redirects to the excel_files list (html)" do
        delete :destroy, params: { id: excel_file.to_param }
        expect(response).to redirect_to(excel_files_path)
        expect(response).to have_http_status(:see_other)
      end

      it "returns no content response (json)" do
        delete :destroy, params: { id: excel_file.to_param, format: :json }
        expect(response).to have_http_status(:no_content)
      end

      it "sets a success notice after destroy" do
        delete :destroy, params: { id: excel_file.to_param }
        expect(flash[:notice]).to eq("Excel file was successfully destroyed.")
      end
      describe 'GET #new' do
        it 'initializes a new excel file' do
          get :new
          expect(assigns(:excel_file)).to be_a_new(ExcelFile)
        end

        it 'renders the new template' do
          get :new
          expect(response).to render_template(:new)
        end
      end
    end

    ####

    include Rails.application.routes.url_helpers
    render_views

    # Clean database between tests
    before(:each) do
      ExcelFile.destroy_all
    end

    describe "GET #index" do
      context "with existing excel files" do
        before do
          # Create test files and ensure they're saved
          @file1 = ExcelFile.create!(
            name: "Test File 1",
            file: fixture_file_upload(
              Rails.root.join('spec', 'fixtures', 'files', 'test.xlsx'),
              'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
            )
          )

          @file2 = ExcelFile.create!(
            name: "Test File 2",
            file: fixture_file_upload(
              Rails.root.join('spec', 'fixtures', 'files', 'test.xlsx'),
              'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
            )
          )

          # Set default URL options for url_for helper
          Rails.application.routes.default_url_options[:host] = 'test.host'
        end

        it "assigns all excel files to @excel_files" do
          get :index
          expect(assigns(:excel_files)).to match_array([@file1, @file2])
        end

        it "renders the index template" do
          get :index
          expect(response).to render_template(:index)
        end

        it "returns a successful response" do
          get :index
          expect(response).to be_successful
        end
      end

      context "when no excel files exist" do
        before do
          ExcelFile.destroy_all
        end

        it "returns an empty collection" do
          get :index
          expect(assigns(:excel_files)).to be_empty
        end

        it "still renders the index template" do
          get :index
          expect(response).to render_template(:index)
        end

        it "returns a successful response" do
          get :index
          expect(response).to be_successful
        end
      end

      context "with JSON format" do
        before do
          @file = ExcelFile.create!(
            name: "Test File",
            file: fixture_file_upload(
              Rails.root.join('spec', 'fixtures', 'files', 'test.xlsx'),
              'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
            )
          )
          # Set default URL options for url_for helper
          Rails.application.routes.default_url_options[:host] = 'test.host'
        end
      end
    end
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
