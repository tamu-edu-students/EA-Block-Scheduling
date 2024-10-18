require 'rails_helper'

RSpec.describe ExcelFilesController, type: :controller do
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

    context "with invalid parameters" do
      it "does not create a new ExcelFile" do
        expect {
          post :create, params: { excel_file: { name: "" } }
        }.not_to change(ExcelFile, :count)

        expect(response).to render_template(:new)
      end
    end
  end
end
