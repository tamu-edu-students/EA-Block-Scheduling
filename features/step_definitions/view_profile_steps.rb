
When("I visit the user's profile page") do
  # Visit the profile page of the logged-in user
  visit user_profile_view_path(User.find_by(email: 'testuser@example.com'))  # Or use the email directly to find the user
end

Then("I should see the user's details") do
  user = User.find_by(email: 'testuser@example.com')  # Ensure you're fetching the correct user
  expect(page).to have_content("Test")  # Check if user's name is on the page
  expect(page).to have_content("testuser@example.com")  # Check if user's email is on the page
end
