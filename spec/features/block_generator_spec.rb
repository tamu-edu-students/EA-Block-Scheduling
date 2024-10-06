require 'rspec'
require 'time'

# CourseClass to represent a class block
class CourseClass
  attr_accessor :course, :start_time, :end_time, :days

  def initialize(course, start_time, end_time, days)
    @course = course
    @start_time = Time.parse(start_time)
    @end_time = Time.parse(end_time)
    @days = days.split(',')  # Days split into individual elements (e.g., ['M', 'W'])
  end
end

# Method to display a block
def generate_block(id, classes)
  "Block #{id}:\n" + classes.map do |block_class|
    "#{block_class.course}: #{block_class.start_time.strftime('%I:%M %p')} - #{block_class.end_time.strftime('%I:%M %p')} on #{block_class.days.join(', ')}"
  end.join("\n") + "\n"
end

# RSpec tests
RSpec.describe 'CourseClass' do
  describe '#initialize' do
    it 'creates a CourseClass object with correct attributes' do
      course = CourseClass.new('MATH-101', '10:00 AM', '11:30 AM', 'M,W')
      expect(course.course).to eq('MATH-101')
      expect(course.start_time.strftime('%I:%M %p')).to eq('10:00 AM')
      expect(course.end_time.strftime('%I:%M %p')).to eq('11:30 AM')
      expect(course.days).to eq(['M', 'W'])  # Now expects split days
    end
  end

  describe '#generate_block' do
    it 'generates a block with correct formatting' do
      class1 = CourseClass.new('ENGR-102-535', '1:30 PM', '3:20 PM', 'M,W')
      class2 = CourseClass.new('MATH-101', '10:00 AM', '11:30 AM', 'T,Th')
      block_output = generate_block(1, [class1, class2])
      
      expected_output = <<~OUTPUT
        Block 1:
        ENGR-102-535: 01:30 PM - 03:20 PM on M, W
        MATH-101: 10:00 AM - 11:30 AM on T, Th
      OUTPUT

      expect(block_output.strip).to eq(expected_output.strip)
    end
  end
end