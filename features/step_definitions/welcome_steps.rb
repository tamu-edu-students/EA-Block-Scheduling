Given("I am logged in as an admin user") do
  # Mock OmniAuth credentials for admin user
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
    provider: 'google_oauth2',
    uid: '12345',
    info: {
      email: 'admin@example.com',
      name: 'Admin User'
    }
  })

  # Create an admin user in the database
  User.create!(
    email: 'admin@example.com',
    first_name: 'Admin',
    last_name: 'User',
    role: 'admin',  # Ensure the role is set to admin
    uid: '12345',
    provider: 'google_oauth2'
  )

  # Simulate the login process
  visit '/auth/google_oauth2/callback'
end

When("I visit the welcome page") do
  visit welcome_path
end

Then("I should be redirected to the admin dashboard") do
  expect(current_path).to eq(admin_dashboard_path)
end

Then("I should see the notice {string}") do |message|
  expect(page).to have_content(message)
end

Given("I am not logged in") do
  Capybara.reset_sessions!
end

Then("I should remain on the welcome page") do
  expect(current_path).to eq(welcome_path)  # Ensure we're still on the welcome page
end

Given("I am logged in as a student user") do
  # Mock the OmniAuth response for the new user
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
    provider: 'google_oauth2',
    uid: '67890',  # Use a different UID for the new user
    info: {
      email: 'differentuser@example.com',  # Different email
      name: 'Different User'               # Different name
    }
  })

  # Simulate the login process by visiting the OmniAuth callback URL
  visit '/auth/google_oauth2/callback'
end

Then("I should be redirected to the students dashboard") do
  expect(current_path).to eq(students_dashboard_path)
end
