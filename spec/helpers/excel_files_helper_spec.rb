# spec/helpers/excel_files_helper_spec.rb

require 'rails_helper'

RSpec.describe ExcelFilesHelper, type: :helper do
  describe '#add_courses_to_database' do
    let(:test_file) { fixture_file_upload('spec/fixtures/files/valid_excel_file_Spring_2025.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet') }
    let(:post) { create(:post) }

    before do
      post.file.attach(test_file)
    end

    context 'when file is an ActiveStorage::Blob' do
      it 'calls FileParser with blob and id' do
        allow(FileParser).to receive(:new).with(post.file.blob, 1).and_return(instance_double(FileParser, successful: true))
        add_courses_to_database(post.file, 1)
      end
    end
  end
end
