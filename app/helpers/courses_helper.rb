module CoursesHelper
  def validate_courses(id)
    as_id = id.to_i
    nil if Course.exists?(as_id: as_id)
  end
end
