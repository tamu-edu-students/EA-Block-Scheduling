# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'FileParser' do
  let(:valid_excel_file) { File.new('spec/fixtures/files/valid_excel_file_Spring_2025.xlsx') }
  let(:invalid_excel_file) { File.new('spec/fixtures/files/invalid_file.txt') }

  describe '#parse' do
    context 'When a valid excel file is passed to parser' do
      it 'the file is successfully parsed' do
        init_count = Course.count
        result = FileParser.new(valid_excel_file).parse
        final_count = Course.count
        expect(result).to be_successful
        expect(init_count < final_count).to be true
      end
    end

    context 'When the excel file is invalid' do
      it 'returns an error' do
        result = FileParser.new(invalid_excel_file).parse

        expect(result).not_to be_successful
        expect(result.errors).to include('Invalid file format')
      end
    end
  end
end
