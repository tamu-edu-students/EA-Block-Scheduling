json.extract! course, :id, :term, :dept_code, :course_id, :sec_coreq_secs, :syn, :sec_name, :short_title, :im, :building, :room, :days, :start_time, :end_time, :fac_id, :faculty_name, :crs_capacity, :sec_cap, :student_count, :notes, :created_at, :updated_at
json.url course_url(course, format: :json)
