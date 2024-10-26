# features/step_definitions/login_reg_steps.rb

Given('I am on the main page') do
  visit home_path
end

When('I click the {string} button for authentication') do |button_text|
  # Since the buttons are links styled as buttons, we use click_link
  click_link button_text
end

Then('I should be redirected to the login page') do
  expect(current_path).to eq login_path
end

Then('I should be redirected to the sign-up page') do
  expect(current_path).to eq signup_path
end
