class CoursesController < ApplicationController
  # before_action :authenticate_user!
  # before_action :admin_only, only: [:upload, :new, :create, :edit, :update, :destroy]
  before_action :set_course, only: %i[ show edit update destroy ]

  # GET /courses or /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1 or /courses/1.json
  def show
    id = params[:id]
    @course = Course.find(id)
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find params[:id]
  end

  def upload
    if params[:file].present?
      uploads = Parser.new(params[:file]).parse
      flash[:notice] = "Courses imported successfully" if uploads.successful?
    else
      flash[:alert] = "Failed to upload courses"
    end
    redirect_to courses_path
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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def course_params
    params.require(:course).permit(:term, :dept_code, :course_id, :sec_coreq_secs, :syn, :sec_name, :short_title, :im, :building, :room, :days, :start_time, :end_time, :fac_id, :faculty_name, :crs_capacity, :sec_cap, :student_count, :notes)
  end

  # def admin_only
  #   unless current_user.admin?
  #     flash[:alert] = "User is not authorized to perform this action."
  #     redirect_to courses_path
  #   end
  # end
end
