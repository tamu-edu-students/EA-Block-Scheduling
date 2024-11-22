module CoursesHelper
  def validate_courses(id)
    as_id = id.to_i
    return if Course.exists?(as_id: as_id)
    flash[:error] = "Courses not found: #{as_id}"
  end

  def get_prerequisite_names(prerequisites)
    return "None" if prerequisites.blank?

    prerequisites.split(",").map do |prereq|
      prereq.strip
    end.uniq.join(", ")
  end
end
