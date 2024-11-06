# frozen_string_literal: true

require 'rspec'

RSpec.describe 'ExcelFilesHelperSpec', type: :helper do
  let(:test_file) do
    fixture_file_upload(
      Rails.root.join('spec', 'fixtures', 'files', 'test.xlsx'),
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    )
  end

  # Testing private methods
  describe 'private methods' do
    # do nothing
  end
end
