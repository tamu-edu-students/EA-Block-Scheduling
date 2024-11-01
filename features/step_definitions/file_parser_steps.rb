require 'cucumber/rails'
require_relative "../../app/services/file_parser"

include Rails.application.routes.url_helpers
World(Rails.application.routes.url_helpers)

Given('an Excel file named {string} with valid course data') do |file|
  @file_path = Rails.root.join('spec/fixtures/files', file)
end

Given('I upload the excel file {string}') do |file|
  @uploaded_file = fixture_file_upload(@file_path, 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
end

When('The file is processed by the Excel parser') do
  @parse_result = FileParser.new(@uploaded_file).parse
end

Then('I should see the parsed data stored in the database') do
  expect(@parse_result.success?).to be_truthy
end

And('The count of courses in the database should have increased') do
  expect(Course.count).to be > 0
end
