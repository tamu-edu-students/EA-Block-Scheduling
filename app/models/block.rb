class Block < ApplicationRecord
    has_and_belongs_to_many :course_classes
  
    def generate_block
      puts "Block #{id}:"
      course_classes.each do |course_class|
        puts "#{course_class.course}: #{course_class.start_time.strftime('%I:%M %p')} - #{course_class.end_time.strftime('%I:%M %p')} on #{course_class.days.join(', ')}"
      end
      puts "\n"
    end
  end