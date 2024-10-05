# spec/features/schedule_generation_spec.rb

require 'rails_helper'

RSpec.feature "Schedule Generation", type: :feature do
  scenario "User views the course list and generates a schedule" do
    visit generate_schedule_path

    # Verify that the table of courses is displayed
    expect(page).to have_content("Selected Courses")
    expect(page).to have_content("Introduction to Computer Science")
    expect(page).to have_content("Dr. Alice Smith")
    expect(page).to have_content("Data Structures")

    # Click the generate schedule button
    click_button "Generate Schedule"

    schedule_banner = find("#schedule-banner", visible: false)

    expect(page).to have_css("#schedule-banner", text: "2 schedules generated", visible: false)

    expect(page).to have_css("#schedule-banner", text: "View Schedule 1", visible: false)
    expect(page).to have_css("#schedule-banner", text: "View Schedule 2", visible: false)
  end
end
