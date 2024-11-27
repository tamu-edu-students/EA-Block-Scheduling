# Background Data
Given("the following prerequisites exist:") do |table|
    puts "\nDEBUG Prerequisites:"
    @prerequisites = table.hashes.each_with_object({}) do |row, hash|
        puts "  Row: #{row.inspect}"
        puts "  Course code: #{row['course_code']}"
        puts "  Prerequisites: #{row['prerequisite_courses']}"
        hash[row['course_code']] = row['prerequisite_courses']
    end
    puts "  Final hash: #{@prerequisites.inspect}"
    
    # Add this debug
    puts "\nDEBUG: Testing prerequisite lookup:"
    puts "  Looking up ENGR-217: #{@prerequisites['ENGR-217']}"
    puts "  Looking up ENGR-217-001: #{@prerequisites['ENGR-217-001']}"
    puts "  All keys: #{@prerequisites.keys}"
end

Given("the following corequisites exist:") do |table|
    @corequisites = table.hashes.each_with_object({}) do |row, hash|
        hash[row['base_code']] = row['corequisite_courses'].split(', ')
    end
end

Given("the following categories exist:") do |table|
    @categories = table.hashes.each_with_object({}) do |row, hash|
        hash[row['type']] = row['category_name']
    end
end

# Verification
# Then("the course {string} should have prerequisites {string}") do |sec_name, prerequisites|
#     course = Course.find_by(sec_name: sec_name)
#     expect(course.prerequisites).to eq(prerequisites)
# end

Then("the course {string} should have prerequisites {string}") do |course_code, prerequisites|
    course = Course.find_by(sec_name: course_code)
    
    puts "\nDEBUG Prerequisites Check:"
    puts "  Course code: #{course_code}"
    puts "  Base course code: #{course.base_course_code}"
    puts "  Course found: #{course.inspect}"
    puts "  Course prerequisites: #{course.prerequisites.inspect}"
    puts "  Expected prerequisites: #{prerequisites}"
    puts "  Stored prerequisites for base code: #{@prerequisites[course.base_course_code]}"
    
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
    expect(course.corequisites.split(/[, ]/).reject(&:empty?)).to match_array(expected_coreqs)
end

# Then("the course {string} should be in category {string}") do |sec_name, category|
#     course = Course.find_by(sec_name: sec_name)
#     expect(course.category).to eq(category)
# end

Then("the course {string} should be in category {string}") do |course_code, category|
    course = Course.find_by(sec_name: course_code)
    expect(course.category).to eq(category)
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
