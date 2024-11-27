When("I log out") do
  visit logout_session_path
end

Then("I should be redirected to the home page") do
  expect(current_path).to eq(root_path)
end

Given("OmniAuth is configured with valid credentials for an admin") do
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
    provider: "google_oauth2",
    uid: "123456789",
    info: {
      email: "admin@example.com",
      name: "Admin User"
    }
  })
  User.create!(
    email: "admin@example.com",
    first_name: "Admin",
    last_name: "User",
    role: "admin",
    uid: "123456789",
    provider: "google_oauth2"
  )
end

Given("OmniAuth is configured with valid credentials for a student") do
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
    provider: "google_oauth2",
    uid: "987654321",
    info: {
      email: "student@example.com",
      name: "Student User"
    }
  })
  User.create!(
    email: "student@example.com",
    first_name: "Student",
    last_name: "User",
    role: "student",
    uid: "987654321",
    provider: "google_oauth2"
  )
end

Given("OmniAuth is configured with invalid credentials") do
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
end

When("I log in via Google") do
  visit "/auth/google_oauth2/callback"
end

When("I try to log in via Google") do
  visit "/auth/google_oauth2/callback"
end

Then("I should be redirected to admin dashboard") do
  expect(current_path).to eq(dashboard_path)
end

And(/^I should see the notice "([^"]*)"$/) do |arg|
  expect(page).to have_content(arg)
end

Then(/^I should be redirected to the students dashboard$/) do
  expect(page).to have_current_path(dashboard_path)
end

And(/^I should see a link with the text "([^"]*)"$/) do |arg|
  expect(page).to have_link(arg)
end

Given("I am logged in as an admin") do
  # Mock the OmniAuth response for an admin user
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
    {
      provider: 'google_oauth2',
      uid: "123", # Use a unique UID for the admin user
      info: {
        email: "adminuser@example.com", # Email for the admin user
        name: "Admin User" # Name for the admin user
      }
    })

  # Simulate the login process by visiting the OmniAuth callback URL
  visit '/auth/google_oauth2/callback'
end

Given("I am logged in as a student") do
  # Mock the OmniAuth response for a student user
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
    {
      provider: 'google_oauth2',
      uid: '67890', # Use a unique UID for the student user
      info: {
        email: 'studentuser@example.com', # Email for the student user
        name: 'Student User' # Name for the student user
      }
    })

  # Simulate the login process by visiting the OmniAuth callback URL
  visit '/auth/google_oauth2/callback'
end

# Given("I am not logged in") do
#   Capybara.reset_sessions!  # Clear the current session to simulate a logged-out state
# end

When("I visit the admin dashboard") do
  visit pages_path # Navigate to the admin dashboard
end

Then("I should see the dashboard page") do
  expect(page).to have_current_path(pages_path) # Check if the user is on the admin dashboard
end

Then("the response should be successful") do
  expect(page.status_code).to eq(200) # Ensure the page load was successful
end

Then("I should be redirected to students dashboard") do
  expect(current_path).to eq(dashboard_path)
end

Then("I should see an alert message {string}") do |message|
  expect(page).to have_content(message) # Verify the alert message is displayed on the page
end

Given(/^I am not logged in$/) do
  # Do nothing to simulate an attempt to access site without being logged in.
end

