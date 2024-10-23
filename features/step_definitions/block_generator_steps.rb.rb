Given("I have the following classes:") do |table|
    @classes = table.hashes.map do |row|
      CourseClass.new(row['course'], row['start_time'], row['end_time'], row['days'])
    end
  end
  
  When("I generate a block with ID {int}") do |id|
    generate_block(id, @classes)
  end
  
  Then("I should see the block with the following details:") do |table|
    expected_classes = table.hashes.map do |row|
      { course: row['course'], start_time: Time.parse(row['start_time']), end_time: Time.parse(row['end_time']), days: row['days'].split(',') }
    end
    
    @classes.each_with_index do |course_class, index|
      expected = expected_classes[index]
      expect(course_class.course).to eq(expected[:course])
      expect(course_class.start_time).to eq(expected[:start_time])
      expect(course_class.end_time).to eq(expected[:end_time])
      expect(course_class.days).to eq(expected[:days])
    end
  end
  