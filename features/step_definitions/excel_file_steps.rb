require 'cucumber/rails'
include Rails.application.routes.url_helpers
World(Rails.application.routes.url_helpers)
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
    click_button button
  end

  Then("I should see {string}") do |content|
    expect(page).to have_content(content)
  end
