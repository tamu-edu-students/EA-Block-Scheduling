class SchedulesController < ApplicationController
  def generate_schedule
    # Mock course data
    @courses = [
      { name: "Introduction to Computer Science", instructor: "Dr. Alice Smith", course_code: "CS101" },
      { name: "Data Structures", instructor: "Dr. Mark Lee", course_code: "CS202" },
      { name: "Operating Systems", instructor: "Prof. Emily Johnson", course_code: "CS301" }
    ]
  end

  def schedule_viewer
    # TODO: Add logic
  end
end
