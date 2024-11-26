When("I log out") do
  visit logout_session_path
end

Then("I should be redirected to the home page") do
  expect(current_path).to eq(pages_path)
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
  expect(current_path).to eq(admin_dashboard_path)
end

And(/^I should see the notice "([^"]*)"$/) do |arg|
  expect(page).to have_content(arg)
end

Then(/^I should be redirected to the students dashboard$/) do
  expect(page).to have_current_path(students_dashboard_path)
end

And(/^I should see a link with the text "([^"]*)"$/) do |arg|
  expect(page).to have_link(arg)
end
