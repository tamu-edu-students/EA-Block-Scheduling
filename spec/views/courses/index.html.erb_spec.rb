require 'rails_helper'

RSpec.describe "courses/index", type: :view do
  before(:each) do
    assign(:courses, [
      Course.create!(
        term: "Term",
        dept_code: "MyText",
        course_id: "Course",
        sec_coreq_secs: "Sec Coreq Secs",
        syn: "Syn",
        sec_name: "Sec Name",
        short_title: "Short Title",
        im: 2,
        building: "Building",
        room: "Room",
        days: "Days",
        fac_id: "Fac",
        faculty_name: "Faculty Name",
        crs_capacity: 3,
        sec_cap: 4,
        student_count: 5,
        notes: "Notes"
      ),
      Course.create!(
        term: "Term",
        dept_code: "MyText",
        course_id: "Course",
        sec_coreq_secs: "Sec Coreq Secs",
        syn: "Syn",
        sec_name: "Sec Name",
        short_title: "Short Title",
        im: 2,
        building: "Building",
        room: "Room",
        days: "Days",
        fac_id: "Fac",
        faculty_name: "Faculty Name",
        crs_capacity: 3,
        sec_cap: 4,
        student_count: 5,
        notes: "Notes"
      )
    ])
  end

  it "renders a list of courses" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Term".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Course".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Sec Coreq Secs".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Syn".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Sec Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Short Title".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Building".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Room".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Days".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Fac".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Faculty Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(4.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(5.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Notes".to_s), count: 2
  end
end
