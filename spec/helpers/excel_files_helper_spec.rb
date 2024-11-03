# spec/helpers/excel_files_helper_spec.rb

require 'rails_helper'

RSpec.describe ExcelFilesHelper, type: :helper do
  include ActionDispatch::TestProcess::FixtureFile
  describe '#add_courses_to_database' do
    context 'when file is an ActiveStorage::Blob' do
      it 'calls FileParser with blob and id' do
        file = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'valid_excel_file_Spring_2025.xlsx'), content_type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
        e_file = ExcelFile.new
        e_file.name = "Test File"
        e_file.file = file
        add_courses_to_database(e_file, 1)
      end
    end
  end
end
