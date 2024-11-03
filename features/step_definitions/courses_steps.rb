Given('the following courses exist:') do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  table.hashes.each do |row|
    Course.create row
  end
end

Given('I am on the courses page to see courses with an active storage id of {int}') do |id|
  visit "/course_uploads/#{id}"
end

Then('I should see {string} in the table') do |term|
  expect(page).to have_content term
end
