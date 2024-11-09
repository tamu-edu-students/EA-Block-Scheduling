# spec/helpers/excel_files_helper_spec.rb

require 'rails_helper'

RSpec.describe ExcelFilesHelper, type: :helper do
  include ActionDispatch::TestProcess::FixtureFile
  describe '#add_courses_to_database' do
    context 'when file is an ActiveStorage::Blob' do
      %w[test.xlsx test2025.xlsx testFall.xlsx valid_excel_file_2025_Fall.xlsx valid_excel_file_Spring_2025.xlsx].each do |file_name|
        it 'calls FileParser with blob and id' do
          file = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', "#{file_name}"), content_type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
          e_file = ExcelFile.new
          e_file.name = "Test File"
          e_file.file = file
          add_courses_to_database(e_file, 1)
        end
      end
    end
  end
end
