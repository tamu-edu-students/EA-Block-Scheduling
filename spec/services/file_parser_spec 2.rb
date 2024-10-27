# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'FileParser' do
  let(:valid_excel_file) { File.new('spec/fixtures/files/valid_excel_file_Spring_2025.xlsx') }
  let(:invalid_excel_file) { File.new('spec/fixtures/files/invalid_file.txt') }

  describe '#parse' do
    context 'When a valid excel file is passed to parser' do
      it 'the file is successfully parsed' do
        result = FileParser.new(valid_excel_file).parse

        expect(result).to be_successful
        expect(result.data).to include({ course: "CHEM 1109-001",
                                         days: "M",
                                         end_time: "1:20PM",
                                         instructor: "Reid, Margaret",
                                         location: "HLC1",
                                         room: 2109,
                                         start_time: "10:30AM",
                                         syn: 92857 })
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
