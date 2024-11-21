# Background Data
Given("the following prerequisites exist:") do |table|
    @prerequisites = table.hashes.each_with_object({}) do |row, hash|
        hash[row['base_code']] = row['prerequisite_courses'].split(', ')
    end
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
    expected_prereqs = prerequisites.split(', ').map(&:strip)
    expect(course.prerequisites.split(', ')).to match_array(expected_prereqs)
end

# Then("the course {string} should have corequisites {string}") do |sec_name, corequisites|
#     course = Course.find_by(sec_name: sec_name)
#     expect(course.corequisites).to eq(corequisites)
# end

Then("the course {string} should have corequisites {string}") do |course_code, corequisites|
    course = Course.find_by(sec_name: course_code)
    expected_coreqs = corequisites.split(', ').map(&:strip)
    expect(course.corequisites.split(', ')).to match_array(expected_coreqs)
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
