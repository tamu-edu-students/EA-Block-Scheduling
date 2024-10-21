require 'time'

# Class to represent a class block
class CourseClass
  attr_accessor :course, :start_time, :end_time, :days

  def initialize(course, start_time, end_time, days)
    @course = course
    @start_time = Time.parse(start_time)
    @end_time = Time.parse(end_time)
    @days = days.split(',')  # Days given as 'MW', 'TTh', etc.
  end
end

# Method to display a block
def generate_block(id, classes)
  puts "Block #{id}:"
  classes.each do |block_class|
    puts "#{block_class.course}: #{block_class.start_time.strftime('%I:%M %p')} - #{block_class.end_time.strftime('%I:%M %p')} on #{block_class.days}"
  end
  puts "\n"
end

# Use this method to get classes from the database
def get_classes
  CourseClass.all
end

# Example usage
classes = get_classes
generate_block(1, classes)
