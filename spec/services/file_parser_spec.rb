# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'FileParser' do
  include ActionDispatch::TestProcess::FixtureFile

  let(:valid_excel_file) { File.new('spec/fixtures/files/valid_excel_file_Spring_2025.xlsx') }
  let(:invalid_excel_file) { File.new('spec/fixtures/files/invalid_file.txt') }
  let(:blob) { ActiveStorage::Blob.create_and_upload!(
    io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'valid_excel_file_Spring_2025.xlsx')),
    filename: 'valid_excel_file_Spring_2025.xlsx',
    content_type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet') }

  describe '#parse' do
    context 'When a valid excel file is passed to parser' do
      it 'the file is successfully parsed' do
        result = valid_parsing(valid_excel_file, 99)
        expect(result[1]).to be_successful
        expect(result[0] < result[2]).to be true
      end
    end

    context 'When a valid blob is passed to parser' do
      it 'the file is successfully parsed' do
        result = valid_parsing(blob, blob.id)
        expect(result[1]).to be_successful
        expect(result[0] < result[2]).to be true
      end
    end

    context 'When the excel file is invalid' do
      it 'returns an error' do
        result = FileParser.new(invalid_excel_file, 0).parse
        expect(result).not_to be_successful
        expect(result.errors).to include('Invalid file format')
      end
    end
  end

  def valid_parsing(thing_to_parse, id)
    init_count = Course.count
    result = FileParser.new(thing_to_parse, id).parse
    final_count = Course.count
    [init_count, result, final_count]
  end
end
