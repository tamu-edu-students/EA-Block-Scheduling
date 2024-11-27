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
    puts "\nDEBUG Categories Setup:"
    puts "  Categories hash: #{@categories.inspect}"
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
  puts "\nDEBUG Category Check:"
  puts "  Course: #{sec_name}"
  puts "  Expected category: #{expected_category}"
  puts "  Actual category: #{course.category}"
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
    expect(course.prerequisites).to be_nil
end

Then("the course {string} should have no corequisites") do |sec_name|
    course = Course.find_by(sec_name: sec_name)
    expect(course.corequisites).to be_nil
end

Then("the course {string} should be in no category") do |sec_name|
    course = Course.find_by(sec_name: sec_name)
    expect(course.category).to be_nil
end

