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
    puts "#{block_class.course}: #{block_class.start_time.strftime('%I:%M %p')} - #{block_class.end_time.strftime('%I:%M %p')} on #{block_class.days.join(', ')}"
  end
  puts "\n"
end

# Creating objects for all classes
engr_102_535 = Class.new('ENGR-102-535', '1:30 PM', '3:20 PM', 'MW')
engr_102_559 = Class.new('ENGR-102-559', '10:30 AM', '12:20 PM', 'MW')
clen_181_1 = Class.new('CLEN-181-1', '12:30 PM', '1:20 PM', 'M')
clen_181_2 = Class.new('CLEN-181-2', '12:00 PM', '12:50 PM', 'T')
clen_181_3 = Class.new('CLEN-181-3', '1:00 PM', '1:50 PM', 'T')
clen_181_4 = Class.new('CLEN-181-4', '2:00 PM', '2:50 PM', 'T')
clen_181_5 = Class.new('CLEN-181-5', '12:30 PM', '1:20 PM', 'W')
clen_181_6 = Class.new('CLEN-181-6', '12:00 PM', '12:50 PM', 'Th')
clen_181_7 = Class.new('CLEN-181-7', '1:00 PM', '1:50 PM', 'Th')

math_2412_017 = Class.new('MATH-2412-017', '4:30 PM', '6:15 PM', 'MW')
math_2412_018 = Class.new('MATH-2412-018', '4:00 PM', '5:45 PM', 'TTh')
math_2412_029 = Class.new('MATH-2412-029', '1:30 PM', '3:15 PM', 'TTh')
math_2413_004 = Class.new('MATH-2413-004', '9:00 AM', '10:45 AM', 'TTh')
math_2413_008 = Class.new('MATH-2413-008', '8:35 AM', '10:20 AM', 'MW')
math_2413_011 = Class.new('MATH-2413-011', '10:55 AM', '12:40 PM', 'TTh')
math_2414_002 = Class.new('MATH-2414-002', '12:50 PM', '2:35 PM', 'TTh')
math_2414_004 = Class.new('MATH-2414-004', '9:00 AM', '10:45 AM', 'TTh')
math_2415_003 = Class.new('MATH-2415-003', '6:00 PM', '7:45 PM', 'MW')
math_2415_004 = Class.new('MATH-2415-004', '8:10 AM', '9:55 AM', 'MW')
math_2420_001 = Class.new('MATH-2420-001', '10:05 AM', '11:50 AM', 'MW')

chem_1309_001 = Class.new('CHEM-1309-001', '9:00 AM', '10:20 AM', 'MW')
chem_1309_002 = Class.new('CHEM-1309-002', '11:00 AM', '12:20 PM', 'TTh')
chem_1309_003 = Class.new('CHEM-1309-003', '12:30 PM', '1:50 PM', 'MW')
chem_1309_007 = Class.new('CHEM-1309-007', '5:00 PM', '6:20 PM', 'TTh')
chem_1312_006 = Class.new('CHEM-1312-006', '2:00 PM', '3:20 PM', 'TTh')

chem_1109_001 = Class.new('CHEM-1109-001', '8:00 AM', '10:50 AM', 'T')
chem_1109_002 = Class.new('CHEM-1109-002', '2:00 PM', '4:50 PM', 'M')
chem_1109_003 = Class.new('CHEM-1109-003', '8:00 AM', '10:50 AM', 'Th')
chem_1109_004 = Class.new('CHEM-1109-004', '2:00 PM', '4:50 PM', 'W')
chem_1109_005 = Class.new('CHEM-1109-005', '10:30 AM', '1:20 PM', 'M')
chem_1109_006 = Class.new('CHEM-1109-006', '10:30 AM', '1:20 PM', 'W')
chem_1109_011 = Class.new('CHEM-1109-011', '2:00 PM', '4:50 PM', 'T')
chem_1109_012 = Class.new('CHEM-1109-012', '2:00 PM', '4:50 PM', 'Th')
chem_1112_005 = Class.new('CHEM-1112-005', '11:00 AM', '1:50 PM', 'Th')
chem_1112_008 = Class.new('CHEM-1112-008', '11:00 AM', '1:50 PM', 'T')

phys_2425_013 = Class.new('PHYS-2425-013', '12:00 PM', '1:30 PM', 'MW')
phys_2425_014 = Class.new('PHYS-2425-014', '3:00 PM', '4:30 PM', 'MW')
phys_2426_005 = Class.new('PHYS-2426-005', '1:30 PM', '3:00 PM', 'MW')
phys_2426_009 = Class.new('PHYS-2426-009', '12:00 PM', '1:30 PM', 'TTh')

end
