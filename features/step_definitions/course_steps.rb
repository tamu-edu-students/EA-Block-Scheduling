# Basic setup steps

When("there is a course {string} in the system") do |title|
  @course = Course.create!(
    term: '224F000',
    dept_code: 'MATH',
    sec_name: 'MATH-2413-008',
    short_title: title,
    days: 'MW',
    start_time: '9:00 AM',
    end_time: '10:20 AM'
  )
end

# Navigation steps
When("I visit the courses page") do
  visit courses_path
end

# Action steps
When("I click course button {string} for section {string}") do |button, section|
  if button == "New Course"
    click_link button
  elsif ["Show", "Edit", "Delete"].include?(button)
    within(:xpath, "//tr[.//td[contains(text(), '#{section}')]]") do
      click_link button
    end
  else
    click_button button
  end
end

When("I fill in course field {string} with {string}") do |field, value|
  field_id = field.downcase.gsub(' ', '_')  # converts "Dept code" to "dept_code"
  fill_in "course_#{field_id}", with: value
end

When('I click course button {string}') do |button_text|
  case button_text
  when "New Course"
    click_link button_text, class: "new-course-button"
  when "Show"
    click_link button_text, class: "show-button"
  when "Edit"
    click_link button_text, class: "edit-button"
  when "Delete"
    click_link button_text, class: "delete-button"
  else
    click_button button_text  # Fallback for actual buttons like "Create Course"
  end
end

# Verification steps
Then("I should see course title {string}") do |title|
  expect(page).to have_content(title)
end

Then("I should not see course title {string}") do |title|
  expect(page).not_to have_content(title)
end

Then("I should see course message {string}") do |message|
  expect(page).to have_content(message)
end

Then("I should not see course title {string} with section {string}") do |title, section|
  expect(page).not_to have_content(section)
end
