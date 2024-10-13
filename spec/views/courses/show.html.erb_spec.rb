require 'rails_helper'

RSpec.describe "courses/show", type: :view do
  before(:each) do
    assign(:course, Course.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Term/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Course/)
    expect(rendered).to match(/Sec Coreq Secs/)
    expect(rendered).to match(/Syn/)
    expect(rendered).to match(/Sec Name/)
    expect(rendered).to match(/Short Title/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Building/)
    expect(rendered).to match(/Room/)
    expect(rendered).to match(/Days/)
    expect(rendered).to match(/Fac/)
    expect(rendered).to match(/Faculty Name/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/Notes/)
  end
end
