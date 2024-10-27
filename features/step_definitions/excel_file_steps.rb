require 'cucumber/rails'

include Rails.application.routes.url_helpers
World(Rails.application.routes.url_helpers)

Before do
  visit new_excel_file_path
  attach_file("File", Rails.root.join('spec', 'fixtures', 'files', "valid_excel_file_Spring_2025.xlsx"))
  @e_file = ExcelFile.last
end

Given("I am on the new excel file page") do
  visit new_excel_file_path
end

Given("I am on the show excel file page") do
  p "------------------------------------------------#{@e_file}------------------------------------------------"
  visit excel_file_path(@e_file)
end

When("I fill in {string} with {string}") do |field, value|
  fill_in field, with: value
end

When("I attach the file {string} to {string}") do |file, field|
  attach_file(field, Rails.root.join('spec', 'fixtures', 'files', file))
end

When("I click {string} on excel page") do |button|
  click_button(button)
end

Then("I should see {string}") do |content|
  expect(page).to have_content(content)
end

When('I am redirected to a page for the newly uploaded file') do
  expect(page).to have_current_path(excel_file_path)
end

When("I click the excel file link") do
  click_link @e_file.file.filename
end

Then("I should see the table of added courses") do
  expect(page).to have_content("CHEM")
end

When("I click on the newly added excel file name link") do
  upload_file_id = ExcelFile.last.id
  file_name = ExcelFile.where(id: upload_file_id).file_name
  click_link file_name
end

Then('I should see {string} classes in a table') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end
