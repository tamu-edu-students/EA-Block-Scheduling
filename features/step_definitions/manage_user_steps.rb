Given("the following users exist:") do |table|
  table.hashes.each do |user|
    User.create!(user)
  end
end

When("I visit the users index page") do
  visit users_path
end

Then("I should see the following users:") do |table|
  table.raw.flatten.each do |email|
    expect(page).to have_content(email)
  end
end

When("I visit the profile page for {string}") do |email|
  user = User.find_by(email: email)
  visit user_path(user)
end

When("I edit the profile of {string} with:") do |email, table|
  user = User.find_by(email: email)
  visit edit_user_path(user)
  table.rows_hash.each do |field, value|
    fill_in field, with: value
  end
  click_button "Update"
end

When("I delete the user {string}") do |email|
  visit users_path
  row = find('table.table tr', text: email)
  action_container = row.find('.action-container')
  trash_icon = action_container.find('a.bi.bi-trash')
  trash_icon.click
end

Then("I should not see {string}") do |email|
  user = User.where(email:).first
  expect(user).to be_nil
end

And 'I log in with Google as {string}' do |email|
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
    {
      provider: "google_oauth2",
      uid: "12345",
      info: {
        email: email,
        name: "Admin User"
      }
    })

  visit omniauth_callback_path
end

And 'there is an admin user with email {string}' do |email|
  FactoryBot.create(:user, :admin, email: email)
end

Given 'I am on the edit user page for the user {string}' do |email|
  user = User.find_by(email:)
  visit edit_user_path(user)
end

When 'I fill in the email field with {string}' do |email|
  fill_in "Email", with: email
end

Then 'I should be redirected to the {string} detail page' do |email|
  user = User.find_by(email:)
  expect(current_path).to eq user_path(user)
end

Then 'I should see the user with email {string}' do |email|
  expect(page).to have_content(email)
end

When('I fill in the first name field with {string}') do |string|
  fill_in 'First name', with: string
end

When('I fill in the last name field with {string}') do |string|
  fill_in 'Last name', with: string
end

Then('I should see the user with first name {string}') do |string|
  expect(page).to have_content(string)
end

Then('I should see the user with last name {string}') do |string|
  expect(page).to have_content(string)
end

Then('I should see the user with role {string}') do |string|
  expect(page).to have_content(string)
end

When('I check the {string} role checkbox') do |role_name|
  check "user_role_ids_#{Role.find_by(name: role_name).id}"
end

When('I uncheck the {string} role checkbox') do |role_name|
  uncheck "user_role_ids_#{Role.find_by(name: role_name).id}"
end

Then('the user should have the {string} role') do |role_name|
  expect(@user.reload.roles).to include(Role.find_by(name: role_name))
end

Then('the user should not have the {string} role') do |role_name|
  expect(@user.reload.roles).not_to include(Role.find_by(name: role_name))
end

Given('a user exists without the {string} role') do |role_name|
  @user = create(:user)
  expect(@user.roles).not_to include(Role.find_by(name: role_name))
end

Given('a user exists with the {string} role') do |role_name|
  @user = create(:user, roles: [Role.find_by(name: role_name)])
end

Given('a user exists without the {string} and {string} roles') do |role_name1, role_name2|
  @user = create(:user)
  expect(@user.roles).not_to include(Role.find_by(name: role_name1))
  expect(@user.roles).not_to include(Role.find_by(name: role_name2))
end

Given('a user exists with the {string} and {string} roles') do |role_name1, role_name2|
  @user = create(:user, roles: [Role.find_by(name: role_name1), Role.find_by(name: role_name2)])
end

Then('the user should have the {string} and {string} roles') do |role_name1, role_name2|
  @user.reload
  expect(@user.roles).to include(Role.find_by(name: role_name1))
  expect(@user.roles).to include(Role.find_by(name: role_name2))
end

Then('the user should not have the {string} and {string} roles') do |role_name1, role_name2|
  @user.reload
  expect(@user.roles).not_to include(Role.find_by(name: role_name1))
  expect(@user.roles).not_to include(Role.find_by(name: role_name2))
end

When('I navigate to the edit user page') do
  visit edit_user_path(@user)
end

When('I check the {string} and {string} role checkboxes') do |role_name1, role_name2|
  check "user_role_ids_#{Role.find_by(name: role_name1).id}"
  check "user_role_ids_#{Role.find_by(name: role_name2).id}"
end

When('I uncheck the {string} and {string} role checkboxes') do |role_name1, role_name2|
  uncheck "user_role_ids_#{Role.find_by(name: role_name1).id}"
  uncheck "user_role_ids_#{Role.find_by(name: role_name2).id}"
end
