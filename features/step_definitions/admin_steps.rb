Given("I am logged in as an admin") do
  # Mock the OmniAuth response for an admin user
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
    provider: 'google_oauth2',
    uid: '12345',  # Use a unique UID for the admin user
    info: {
      email: 'adminuser@example.com',  # Email for the admin user
      name: 'Admin User'              # Name for the admin user
    }
  })

  # Simulate the login process by visiting the OmniAuth callback URL
  visit '/auth/google_oauth2/callback'
end

Given("I am logged in as a student") do
  # Mock the OmniAuth response for a student user
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
    provider: 'google_oauth2',
    uid: '67890',  # Use a unique UID for the student user
    info: {
      email: 'studentuser@example.com',  # Email for the student user
      name: 'Student User'              # Name for the student user
    }
  })

  # Simulate the login process by visiting the OmniAuth callback URL
  visit '/auth/google_oauth2/callback'
end

# Given("I am not logged in") do
#   Capybara.reset_sessions!  # Clear the current session to simulate a logged-out state
# end

When("I visit the admin dashboard") do
  visit admin_dashboard_path  # Navigate to the admin dashboard
end

Then("I should see the dashboard page") do
  expect(page).to have_current_path(root_path + "dashboard")  # Check if the user is on the admin dashboard
end

Then("the response should be successful") do
  expect(page.status_code).to eq(200)  # Ensure the page load was successful
end

Then("I should be redirected to students dashboard") do
  expect(current_path).to eq(students_dashboard_path)
end

Then("I should see an alert message {string}") do |message|
  expect(page).to have_content(message)  # Verify the alert message is displayed on the page
end

Given(/^I am not logged in$/) do
  # Do nothing to simulate an attempt to access site without being logged in.
end
