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

  # Gets the course code from the sec_name (e.g. MATH-2414 from MATH-2414-007)
  def extract_base_code(sec_name)
    standardized = sec_name.gsub(" ", "-")
    parts = standardized.split("-")
    "#{parts[0]}-#{parts[1]}"
  end

  # Get type of course from sec_name using extract_base_code (e.g. MATH from MATH-2414-007)
  def extract_type(sec_name)
    base_code = extract_base_code(sec_name)
    parts = base_code.split("-")
    parts[0]
  end

  # Define prereqs and coreqs for listed courses for populating columns during creation
  def corequisites
    {
      "ENGR-102" => %w[MATH-2412 MATH-2413],
      "ENGR-216" => ["PHYS-2425"],
      "ENGR-217" => ["PHYS-2426"]
    }
  end
  def prerequisites
    {
      "MATH-2413" => ["MATH-2412"],
      "MATH-2414" => ["MATH-2413"],
      "MATH-2415" => ["MATH-2414"],
      "MATH-2420" => ["MATH-2415"],
      "ENGR-216" => %w[ENGR-102 MATH-2413],
      "ENGR-217" => %w[ENGR-216 PHYS-2425 MATH-2414],
      "CHEM-1312" => ["CHEM-1309"],
      "CHEM-1112" => ["CHEM-1309"],
      "PHYS-2425" => ["MATH-2413"],
      "PHYS-2426" => %w[MATH-2414 PHYS-2425]
    }
  end

  # Define categories of courses based on class code
  def categories
    {
      "MATH" => "Math",
      "PHYS" => "Science",
      "CHEM" => "Science",
      "ENGR" => "Engineering",
      "CLEN" => "Intro"
    }
  end
end
