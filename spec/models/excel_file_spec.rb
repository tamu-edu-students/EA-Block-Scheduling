require 'rails_helper'

RSpec.describe ExcelFile, type: :model do
  it "is valid with a name and attached Excel file" do
    excel_file = ExcelFile.new(name: "Test File")
    excel_file.file.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test.xlsx')), filename: 'test.xlsx', content_type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
    expect(excel_file).to be_valid
  end

  it "is invalid without a name" do
    excel_file = ExcelFile.new
    excel_file.valid?
    expect(excel_file.errors[:name]).to include("can't be blank")
  end

  it "is invalid without an attached file" do
    excel_file = ExcelFile.new(name: "Test File")
    excel_file.valid?
    expect(excel_file.errors[:file]).to include("can't be blank")
  end

  it "is invalid with a non-Excel file" do
    excel_file = ExcelFile.new(name: "Test File")
    excel_file.file.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test.txt')), filename: 'test.txt', content_type: 'text/plain')
    excel_file.valid?
    expect(excel_file.errors[:file]).to include("must be an Excel file")
  end

  describe "#process_file" do
    it "processes the uploaded Excel file" do
      excel_file = ExcelFile.create(name: "Test File")
      excel_file.file.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test.xlsx')), filename: 'test.xlsx', content_type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')

      expect { excel_file.process_file }.not_to raise_error
      # Add more specific expectations based on your processing logic
    end
  end

  describe "#process_file" do
    it "processes the uploaded Excel file" do
      excel_file = ExcelFile.new(name: "Test File")
      file_path = Rails.root.join('spec', 'fixtures', 'files', 'test.xlsx')
      excel_file.file.attach(io: File.open(file_path), filename: 'test.xlsx', content_type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
      excel_file.save!

      expect(excel_file.file).to be_attached
      expect { excel_file.process_file }.not_to raise_error
    end
  end
end

# Controller specs
RSpec.describe ExcelFilesController, type: :controller do
  let(:valid_attributes) do
    {
      name: "Test File",
      file: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.xlsx'), 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
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

      #   it "returns a success response (json)" do
      #     put :update, params: { id: excel_file.to_param, excel_file: new_attributes, format: :json }
      #     expect(response).to have_http_status(:ok)
      #     expect(response.content_type).to include("application/json")
      #   end
      # end

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
          expect(assigns(:excel_files)).to match_array([ @file1, @file2 ])
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

        # it "returns JSON formatted response" do
        #   get :index, format: :json
        #   expect(response.content_type).to include('application/json')
        # end

        # it "includes the excel files in the JSON response" do
        #   get :index, format: :json
        #   json_response = JSON.parse(response.body)
        #   expect(json_response.length).to eq(1)
        #   expect(json_response.first['name']).to eq('Test File')
        #   expect(json_response.first).to have_key('file')
        #   expect(json_response.first).to have_key('url')
      end
    end
  end
end

RSpec.describe ApplicationHelper, type: :helper do
  include ActionDispatch::TestProcess

  let(:test_file) do
    fixture_file_upload(
      Rails.root.join('spec', 'fixtures', 'files', 'test.xlsx'),
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    )
  end

  describe '#attachment_url' do
    let(:excel_file) { ExcelFile.new(name: "Test File") }

    context 'in test environment' do
      before do
        allow(Rails.env).to receive(:test?).and_return(true)
      end

      it 'returns test attachment url' do
        expect(helper.attachment_url(excel_file.file)).to eq("#")
      end
    end

    context 'in non-test environment' do
      before do
        allow(Rails.env).to receive(:test?).and_return(false)
      end

      context 'when attachment is not attached' do
        it 'returns default attachment url' do
          expect(helper.attachment_url(excel_file.file)).to eq("/assets/default-attachment.png")
        end
      end

      context 'when attachment is attached' do
        before do
          excel_file.file.attach(test_file)
        end

        it 'returns real attachment url' do
          expect(helper).to receive(:real_attachment_url).with(excel_file.file)
          helper.attachment_url(excel_file.file)
        end
      end
    end
  end

  # Testing private methods
  describe 'private methods' do
    describe '#test_attachment_url' do
      it 'returns "#"' do
        expect(helper.send(:test_attachment_url)).to eq("#")
      end
    end

    describe '#default_attachment_url' do
      it 'returns default asset path' do
        expect(helper.send(:default_attachment_url)).to eq("/assets/default-attachment.png")
      end
    end

    # describe '#real_attachment_url' do
    #   let(:excel_file) { ExcelFile.new(name: "Test File") }
    #
    #   before do
    #     excel_file.file.attach(test_file)
    #   end
    #
    #   it 'returns url for attached file' do
    #     # Instead of testing the exact URL, we'll test that it calls url_for
    #     expect(helper).to receive(:url_for).with(excel_file.file)
    #     helper.send(:real_attachment_url, excel_file.file)
    #   end
    # end
  end
end

RSpec.describe ExcelFile, type: :model do
  describe '#process_file' do
    let(:excel_file) do
      ExcelFile.new.tap do |ef|
        ef.file = fixture_file_upload('test.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
      end
    end

    context 'when in production environment' do
      before do
        allow(Rails.env).to receive(:test?).and_return(false)
        allow(excel_file.file).to receive(:download).and_return('dummy_file_path')
        allow(excel_file.file).to receive(:attached?).and_return(true)
      end

      let(:spreadsheet_mock) do
        instance_double('Roo::Excelx').tap do |spreadsheet|
          allow(spreadsheet).to receive(:row).and_return([ 'header1', 'header2' ])
          allow(spreadsheet).to receive(:last_row).and_return(2)
        end
      end

      it 'processes downloaded file with xlsx extension' do
        expect(Roo::Spreadsheet).to receive(:open)
                                      .with('dummy_file_path', extension: :xlsx)
                                      .and_return(spreadsheet_mock)

        excel_file.process_file
      end
    end
  end
end
