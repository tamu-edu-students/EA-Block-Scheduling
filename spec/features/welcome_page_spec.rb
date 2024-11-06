# spec/features/welcome_page_spec.rb
require 'rails_helper'

RSpec.feature "Welcome Page", type: :feature do
  scenario "user visits the welcome page" do
    visit welcome_path
    expect(current_path).to eq(welcome_path)  # Ensure we're on the welcome page
  end
end

RSpec.feature "Welcome Page", type: :feature do
  scenario "user is redirected to the admin dashboard if logged in as an admin" do
    # Simulate logging in as an admin
    login_as_admin_user
    visit welcome_path
    expect("/admin" + current_path).to eq(admin_dashboard_path)
    expect(page).to have_content("Welcome back!")  # Assuming this message appears on successful login
  end
end


RSpec.feature "Welcome Page", type: :feature do
  scenario "user should see the notice after login" do
    login_as_admin_user  # Simulating login
    visit welcome_path
    expect(page).to have_content("Welcome back!")  # Assuming 'Welcome back!' is the notice
  end
end