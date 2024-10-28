require 'cucumber/rails'

include Rails.application.routes.url_helpers
# World(Rails.application.routes.url_helpers)

Given("I am on the new excel file page") do
  visit new_excel_file_path
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

When('I fill in the {string} field with {string}') do |field, value|
  fill_in field, with: value
end

When('I attach the {string} field with {string}') do |field, file|
  attach_file(field, Rails.root.join('spec', 'fixtures', 'files', file))
end

When("I click {string} button") do |button|
  click_button(button)
  # find("input[type='submit']").click
end

Then('The active storage db should have a record of the file') do
  ex_file = ExcelFile.last
  expect(ex_file.file.attached?).to be_truthy
  expect(ex_file.file.blob.filename.to_s).to eq("valid_excel_file_Spring_2025.xlsx")
end
