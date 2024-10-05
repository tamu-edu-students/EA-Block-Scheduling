# spec/views/schedules/generate_schedule.html.erb_spec.rb

require 'rails_helper'

RSpec.describe "schedules/generate_schedule.html.erb", type: :view do
  before do
    assign(:courses, [
      { name: "Introduction to Computer Science", instructor: "Dr. Alice Smith", course_code: "CS101" },
      { name: "Data Structures", instructor: "Dr. Mark Lee", course_code: "CS202" },
      { name: "Operating Systems", instructor: "Prof. Emily Johnson", course_code: "CS301" }
    ])
    render
  end

  it "displays the heading 'Selected Courses'" do
    expect(rendered).to have_selector('h1', text: 'Selected Courses')
  end

  it "displays the course details in a table" do
    expect(rendered).to have_selector('table')
    expect(rendered).to have_content('Introduction to Computer Science')
    expect(rendered).to have_content('Dr. Alice Smith')
    expect(rendered).to have_content('CS101')
    expect(rendered).to have_content('Data Structures')
    expect(rendered).to have_content('Operating Systems')
  end

  it "displays the generate schedule button" do
    expect(rendered).to have_selector('button#generate-schedule-button', text: 'Generate Schedule')
  end
end
