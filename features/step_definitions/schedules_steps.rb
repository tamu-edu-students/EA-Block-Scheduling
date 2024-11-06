# features/step_definitions/schedules_steps.rb
include Rails.application.routes.url_helpers

Given('I am on the {string} page') do |page_name|
  visit generate_schedule_schedules_path
end

When('I visit the {string} page') do |page_name|
  visit generate_schedule_schedules_path
end

Then('I should see the {string} title') do |title|
  expect(page).to have_content(title)
end

Then('I should see a table with course codes, names, and instructors') do
  expect(page).to have_selector('table')
  within('table') do
    expect(page).to have_content('Course Code')
    expect(page).to have_content('Course Name')
    expect(page).to have_content('Instructor')
  end
end

Then('I should see the following courses:') do |table|
  table.hashes.each do |course|
    expect(page).to have_content(course['Course Code'])
    expect(page).to have_content(course['Course Name'])
    expect(page).to have_content(course['Instructor'])
  end
end

Then('I should see the {string} button') do |button_text|
  expect(page).to have_button(button_text)
end

When('I click the {string} button') do |button_text|
  click_button(button_text)
end

Then("I should see {string} in the schedule banner") do |expected_text|
  click_button("Generate Schedule")
  sleep 2
  expect(page).to have_css("#schedule-banner", text: expected_text, visible: false)
end

Then('I should see links {string} and {string}') do |link1, link2|
  expect(page).to have_css("#schedule-banner", text: link1, visible: false)
  expect(page).to have_css("#schedule-banner", text: link2, visible: false)
end

When('I click {string}') do |link|
  click_link(link)
end

Then('I should be redirected to the {string} page') do |page_name|
  expect(current_path).to eq(show_schedule_path)
end

Then('I should see the schedule containing:') do |table|
  table.hashes.each do |course|
    expect(page).to have_content(course['Course Code'])
    expect(page).to have_content(course['Course Name'])
    expect(page).to have_content(course['Instructor'])
  end
end
