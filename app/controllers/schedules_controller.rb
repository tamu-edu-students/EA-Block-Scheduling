class SchedulesController < ApplicationController
  def generate_schedule
    # Mock course data
    @courses = [
      { name: "Introduction to Computer Science", instructor: "Dr. Alice Smith", course_code: "CS101" },
      { name: "Data Structures", instructor: "Dr. Mark Lee", course_code: "CS202" },
      { name: "Operating Systems", instructor: "Prof. Emily Johnson", course_code: "CS301" }
    ]
  end

  def index
    @schedules = Schedule.all
  end

  def create
    @schedule = Schedule.new(schedule_params)
    
    # TODO: scheduling algortithm
    
    if @schedule.save
      redirect_to @schedule, notice: 'Schedule was successfully created.'
    else
      render :new
    end
  end
end
