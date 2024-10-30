class CoursesController < ApplicationController
  before_action :set_course, only: %i[ show edit update destroy ]

  # GET /courses or /courses.json
  def index
    @courses = Course.all.order(:sec_name)
  end

  # GET /courses/1 or /courses/1.json
  def show
    @prerequisites = @course.get_prerequisites
  end

  # POST /courses or /courses.json
  def create
    @course = Course.create!(course_params)
    flash[:notice] = "#{@course.short_title} was successfully created."
    redirect_to courses_path
  rescue ActiveRecord::RecordInvalid => e
    flash[:alert] = e.message
    render :new, status: :unprocessable_entity
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    # Remove redundant find since we have before_action
    @course.update!(course_params)
    flash[:notice] = "#{@course.short_title} was successfully updated."
    redirect_to course_path(@course)
  rescue ActiveRecord::RecordInvalid => e
    flash[:alert] = e.message
    render :edit, status: :unprocessable_entity
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.destroy
    flash[:notice] = "#{@course.short_title} was successfully deleted."
    redirect_to courses_path
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

      sec_coreq_secs.split(",").map { |prereq| process_prerequisite(prereq) }.uniq
    end

    def process_prerequisite(prereq)
      if syn_number?(prereq)
        find_course_name(prereq) || prereq
      else
        format_course_name(prereq)
      end
    end

    def syn_number?(prereq)
      prereq.match?(/^\d+$/)
    end

    def find_course_name(prereq)
      course = Course.find_by(syn: prereq)
      course&.sec_name&.split("-")&.first(2)&.join("-")
    end

    def format_course_name(prereq)
      prereq.split("-").first(2).join("-")
    end
end
