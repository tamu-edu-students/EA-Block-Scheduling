require 'rails_helper'

RSpec.describe "courses/edit", type: :view do
  let(:course) {
    Course.create!(
      term: "MyString",
      dept_code: "MyText",
      course_id: "MyString",
      sec_coreq_secs: "MyString",
      syn: "MyString",
      sec_name: "MyString",
      short_title: "MyString",
      im: 1,
      building: "MyString",
      room: "MyString",
      days: "MyString",
      fac_id: "MyString",
      faculty_name: "MyString",
      crs_capacity: 1,
      sec_cap: 1,
      student_count: 1,
      notes: "MyString"
    )
  }

  before(:each) do
    assign(:course, course)
  end

  it "renders the edit course form" do
    render

    assert_select "form[action=?][method=?]", course_path(course), "post" do

      assert_select "input[name=?]", "course[term]"

      assert_select "textarea[name=?]", "course[dept_code]"

      assert_select "input[name=?]", "course[course_id]"

      assert_select "input[name=?]", "course[sec_coreq_secs]"

      assert_select "input[name=?]", "course[syn]"

      assert_select "input[name=?]", "course[sec_name]"

      assert_select "input[name=?]", "course[short_title]"

      assert_select "input[name=?]", "course[im]"

      assert_select "input[name=?]", "course[building]"

      assert_select "input[name=?]", "course[room]"

      assert_select "input[name=?]", "course[days]"

      assert_select "input[name=?]", "course[fac_id]"

      assert_select "input[name=?]", "course[faculty_name]"

      assert_select "input[name=?]", "course[crs_capacity]"

      assert_select "input[name=?]", "course[sec_cap]"

      assert_select "input[name=?]", "course[student_count]"

      assert_select "input[name=?]", "course[notes]"
    end
  end
end
