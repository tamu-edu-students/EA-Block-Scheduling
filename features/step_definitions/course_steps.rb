# Basic setup steps
Before do
  @prerequisites = {}
  @corequisites = {}
  @categories = {}
end

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
  elsif %w[Edit Delete].include?(button)
    within(:xpath, "//tr[.//td[contains(text(), '#{section}')]]") do
      if button == "Delete"
        click_link "", class: "bi bi-trash"
      else
        click_link "", class: "bi bi-pencil"
      end
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
  if button_text == "Create Course"
    sec_name = find_field('course_sec_name').value
    base_code = sec_name.split('-')[0..1].join('-')
    dept_code = sec_name.split('-')[0]
    
    puts "\nDEBUG Course Creation:"
    puts "  Section name: #{sec_name}"
    puts "  Department: #{dept_code}"
    puts "  Available categories: #{@categories.inspect}"
    
    # Debug available fields
    puts "\nDEBUG Available Fields:"
    all('input, select, textarea').each do |field|
      puts "  Field: #{field['name']} (id: #{field['id']}, type: #{field['type']})"
    end
    
    # Set prerequisites in the form
    if @prerequisites && @prerequisites[base_code]
      fill_in 'Prerequisites', with: @prerequisites[base_code]
    end

    # Set corequisites in the form
    if @corequisites && @corequisites[base_code]
      fill_in 'Corequisites', with: @corequisites[base_code]
    end

    # Set category based on department code
    if @categories && @categories[dept_code]
      puts "  Setting category to: #{@categories[dept_code]}"
      fill_in 'course[category]', with: @categories[dept_code]
    end
  end
  
  case button_text
  when "New Course"
    click_link button_text, class: "new-course-button"
  when "Edit"
    click_link button_text, class: "bi bi-pencil"
  when "Delete"
    click_link button_text, class: "bi bi-trash"
  else
    click_button button_text
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
