class CoursesController < ApplicationController
  include CoursesHelper
  # before_action :authenticate_user!
  # before_action :admin_only, only: [:upload, :new, :create, :edit, :update, :destroy]
  before_action :set_course, only: %i[ show edit update destroy ]

  # GET /courses or /courses.json
  def index
    @courses = Course.all.order(:sec_name)
    @prerequisites = {}

    @courses.each do |course|
      if course.prerequisites.present?
        @prerequisites[course.sec_name] = course.prerequisites.split(", ").map(&:strip)
      end
    end
  end

  # GET /courses/1 or /courses/1.json
  def show
    @prerequisites = @course.prerequisites&.split(", ")&.map(&:strip)
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)

    if @course.save
      flash[:notice] = "#{@course.short_title} was successfully created."
      redirect_to courses_path
    else
      flash.now[:alert] = @course.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    if @course.update(course_params)
      flash[:notice] = "#{@course.short_title} was successfully updated."
      redirect_to course_path(@course)
    else
      flash.now[:alert] = @course.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    flash[:notice] = "Course was successfully deleted"
    redirect_to courses_path
  end

  def new
    @course = Course.new
  end

  # show recently uploaded courses
  def show_by_upload
    as_id = params[:as_id]
    validate_courses(as_id)
    @courses = Course.where(as_id: as_id)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find(params[:id])
  end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(
        :term,
        :dept_code,
        :course_id,
        :sec_coreq_secs,
        :syn,
        :sec_name,
        :short_title,
        :im,
        :building,
        :room,
        :days,
        :start_time,
        :end_time,
        :fac_id,
        :faculty_name,
        :crs_capacity,
        :sec_cap,
        :student_count,
        :notes,
        :prerequisites,
        :as_id
      )
    end

  # def admin_only
  #   unless current_user.admin?
  #     flash[:alert] = "User is not authorized to perform this action."
  #     redirect_to courses_path
  #   end
  # end
end
