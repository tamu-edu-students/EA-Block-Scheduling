class CoursesController < ApplicationController
  before_action :set_course, only: %i[ show edit update destroy ]

  # GET /courses or /courses.json
  def index
    @courses = Course.all.order(:sec_name)
  end

  # GET /courses/1 or /courses/1.json
  def show
    @course = Course.find(params[:id])
    @prerequisites = get_prerequisite_names(@course.sec_coreq_secs)
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find params[:id]
  end

  # POST /courses or /courses.json
  def create
    @course = Course.create!(course_params)
    flash[:notice] = "#{@course.short_title} was successfully created."
    redirect_to courses_path
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    @course = Course.find params[:id]
    @course.update!(course_params)
    flash[:notice] = "#{@course.short_title} was successfully updated."
    redirect_to course_path(@course)
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    flash[:notice] = "#{@course.short_title} was successfully deleted."
    redirect_to courses_path
  end

  # GET /courses/selection
  def selection
    @courses = Course.all
  end

  # POST /courses/available
  def available
    completed_courses = params[:completed_courses] || []
    available_courses = Course.available_courses(completed_courses)
    render json: available_courses.map { |course|
      {
        syn: course.syn,
        sec_name: course.sec_name,
        short_title: course.short_title
      }
    }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:term, :dept_code, :course_id, :sec_coreq_secs, :syn, :sec_name, :short_title, :im, :building, :room, :days, :start_time, :end_time, :fac_id, :faculty_name, :crs_capacity, :sec_cap, :student_count, :notes)
    end

    def get_prerequisite_names(sec_coreq_secs)
      return [] if sec_coreq_secs.blank?

      sec_coreq_secs.split(",").map do |prereq|
        if prereq.match?(/^\d+$/) # if it's a syn number
          course = Course.find_by(syn: prereq)
          course ? course.sec_name.split("-")[0..1].join("-") : prereq
        else
          prereq.split("-")[0..1].join("-") # if it's already a course name
        end
      end.uniq
    end
end
