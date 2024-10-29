class Block < ApplicationRecord
    has_and_belongs_to_many :course_classes

    def generate_block
      puts "Block #{id}:"
      course.each do |course|
        puts "#{course.course}: #{course.start_time.strftime('%I:%M %p')} - #{course.end_time.strftime('%I:%M %p')} on #{course.days.join(', ')}"
      end
      puts "\n"
    end
end
