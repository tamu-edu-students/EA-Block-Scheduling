Given('An Excel file has been uploaded as an ActiveStorage::Blob') do
  @blob = ActiveStorage::Blob.create_and_upload!(
    io: File.open('spec/fixtures/files/valid_excel_file_Spring_2025.xlsx'),
    filename: 'valid_excel_file_Spring_2025.xlsx',
    content_type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
  )
  @file_id = @blob.id
end

When('The system processes the file with add_courses_to_database') do
  extend ExcelFilesHelper
  results = add_courses_to_database(@blob, @file_id)
  p results.errors
end

Then('The courses should be added to the database') do
  expect(Course.count).to be > 0
end
