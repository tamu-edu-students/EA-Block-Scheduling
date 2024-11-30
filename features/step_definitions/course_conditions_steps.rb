# Background Data
Given("the following prerequisites exist:") do |table|
    @prerequisites = table.hashes.each_with_object({}) do |row, hash|
        hash[row['course_code']] = row['prerequisite_courses']
    end
end

Given("the following corequisites exist:") do |table|
    @corequisites = table.hashes.each_with_object({}) do |row, hash|
        hash[row['course_code']] = row['corequisite_courses']
    end
end

Given("the following categories exist:") do |table|
    @categories = table.hashes.each_with_object({}) do |row, hash|
        hash[row['type']] = row['category_name']
    end
end

Then("the course {string} should have prerequisites {string}") do |course_code, prerequisites|
    course = Course.find_by(sec_name: course_code)
    expected_prereqs = prerequisites.split(/[, ]/).reject(&:empty?)
    actual_prereqs = course.prerequisites.nil? ? [] : course.prerequisites.split(/[, ]/).reject(&:empty?)
    expect(actual_prereqs).to match_array(expected_prereqs)
end

# Then("the course {string} should have corequisites {string}") do |sec_name, corequisites|
#     course = Course.find_by(sec_name: sec_name)
#     expect(course.corequisites).to eq(corequisites)
# end

Then("the course {string} should have corequisites {string}") do |course_code, corequisites|
  course = Course.find_by(sec_name: course_code)
  expected_coreqs = corequisites.split(/[, ]/).reject(&:empty?)
  actual_coreqs = course.corequisites.nil? ? [] : course.corequisites.split(/[, ]/).reject(&:empty?)
  expect(actual_coreqs).to match_array(expected_coreqs)
end
# Then("the course {string} should be in category {string}") do |sec_name, category|
#     course = Course.find_by(sec_name: sec_name)
#     expect(course.category).to eq(category)
# end

Then("the course {string} should be in category {string}") do |sec_name, expected_category|
  course = Course.find_by(sec_name: sec_name)
  expect(course.category).to eq(expected_category)
end

# Then("the course {string} should have no prerequisites") do |sec_name|
#     course = Course.find_by(sec_name: sec_name)
#     expect(course.prerequisites).to be_nil
# end

# Then("the course {string} should have no corequisites") do |sec_name|
#     course = Course.find_by(sec_name: sec_name)
#     expect(course.corequisites).to be_nil
# end

# Then("the course {string} should be in no category") do |sec_name|
#     course = Course.find_by(sec_name: sec_name)
#     expect(course.category).to be_nil
# end

Then("the course {string} should have no prerequisites") do |sec_name|
  course = Course.find_by(sec_name: sec_name)
  expect(course.prerequisites.presence).to be_nil
end

Then("the course {string} should have no corequisites") do |sec_name|
  course = Course.find_by(sec_name: sec_name)
  expect(course.corequisites.presence).to be_nil
end

Then("the course {string} should be in no category") do |sec_name|
  course = Course.find_by(sec_name: sec_name)
  expect(course.category.presence).to be_nil
end

Then("the course base code should be {string}") do |expected_code|
  course = Course.last
  base_code = CoursesHelper.extract_base_code(course.sec_name)
  expect(base_code).to eq(expected_code)
end

Then("the course type should be {string}") do |expected_type|
  course = Course.last
  type = CoursesHelper.extract_type(course.sec_name)
  expect(type).to eq(expected_type)
end
