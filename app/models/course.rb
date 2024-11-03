class Course < ApplicationRecord
  validates :prerequisites, format: {
    with: /\A(?:|(?:[A-Z]{2,4}(?:[ -])\d{3,4}(?:-(?:\d{1,3}))?(?:,\s*[A-Z]{2,4}(?:[ -])\d{3,4}(?:-(?:\d{1,3}))?)*?))\z/,
    message: "must be a comma-separated list of course codes (e.g., 'MATH-2413' or 'MATH 2413' or 'MATH-2413-001')"
  }, allow_nil: true

  validates :sec_name, presence: true

  def get_prerequisites
    return [] if prerequisites.blank?
    prerequisites.split(",").map(&:strip)
  end

  def base_course_code
    sec_name.split("-")[0..1].join("-")
  end

  def prerequisite_courses
    get_prerequisites.map { |prereq| Course.find_by(sec_name: prereq) }.compact
  end

  def prerequisites_met?(completed_courses)
    return true if get_prerequisites.empty?
    get_prerequisites.all? do |prereq|
      completed_courses.any? { |course| course.base_course_code == prereq.split("-")[0..1].join("-") }
    end
  end
end
