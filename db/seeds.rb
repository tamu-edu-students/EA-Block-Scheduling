# Clear existing data
CourseClass.destroy_all

# Array of course data
course_data = [
  ['ENGR-102-535', '1:30 PM', '3:20 PM', 'MW'],
  ['ENGR-102-559', '10:30 AM', '12:20 PM', 'MW'],
  ['CLEN-181-1', '12:30 PM', '1:20 PM', 'M'],
  ['CLEN-181-2', '12:00 PM', '12:50 PM', 'T'],
  ['CLEN-181-3', '1:00 PM', '1:50 PM', 'T'],
  ['CLEN-181-4', '2:00 PM', '2:50 PM', 'T'],
  ['CLEN-181-5', '12:30 PM', '1:20 PM', 'W'],
  ['CLEN-181-6', '12:00 PM', '12:50 PM', 'Th'],
  ['CLEN-181-7', '1:00 PM', '1:50 PM', 'Th'],
  ['MATH-2412-017', '4:30 PM', '6:15 PM', 'MW'],
  ['MATH-2412-018', '4:00 PM', '5:45 PM', 'TTh'],
  ['MATH-2412-029', '1:30 PM', '3:15 PM', 'TTh'],
  ['MATH-2413-004', '9:00 AM', '10:45 AM', 'TTh'],
  ['MATH-2413-008', '8:35 AM', '10:20 AM', 'MW'],
  ['MATH-2413-011', '10:55 AM', '12:40 PM', 'TTh'],
  ['MATH-2414-002', '12:50 PM', '2:35 PM', 'TTh'],
  ['MATH-2414-004', '9:00 AM', '10:45 AM', 'TTh'],
  ['MATH-2415-003', '6:00 PM', '7:45 PM', 'MW'],
  ['MATH-2415-004', '8:10 AM', '9:55 AM', 'MW'],
  ['MATH-2420-001', '10:05 AM', '11:50 AM', 'MW'],
  ['CHEM-1309-001', '9:00 AM', '10:20 AM', 'MW'],
  ['CHEM-1309-002', '11:00 AM', '12:20 PM', 'TTh'],
  ['CHEM-1309-003', '12:30 PM', '1:50 PM', 'MW'],
  ['CHEM-1309-007', '5:00 PM', '6:20 PM', 'TTh'],
  ['CHEM-1312-006', '2:00 PM', '3:20 PM', 'TTh'],
  ['CHEM-1109-001', '8:00 AM', '10:50 AM', 'T'],
  ['CHEM-1109-002', '2:00 PM', '4:50 PM', 'M'],
  ['CHEM-1109-003', '8:00 AM', '10:50 AM', 'Th'],
  ['CHEM-1109-004', '2:00 PM', '4:50 PM', 'W'],
  ['CHEM-1109-005', '10:30 AM', '1:20 PM', 'M'],
  ['CHEM-1109-006', '10:30 AM', '1:20 PM', 'W'],
  ['CHEM-1109-011', '2:00 PM', '4:50 PM', 'T'],
  ['CHEM-1109-012', '2:00 PM', '4:50 PM', 'Th'],
  ['CHEM-1112-005', '11:00 AM', '1:50 PM', 'Th'],
  ['CHEM-1112-008', '11:00 AM', '1:50 PM', 'T'],
  ['PHYS-2425-013', '12:00 PM', '1:30 PM', 'MW'],
  ['PHYS-2425-014', '3:00 PM', '4:30 PM', 'MW'],
  ['PHYS-2426-005', '1:30 PM', '3:00 PM', 'MW'],
  ['PHYS-2426-009', '12:00 PM', '1:30 PM', 'TTh']
]

# Create CourseClass instances
course_data.each do |course, start_time, end_time, days|
  CourseClass.create!(
    course: course,
    start_time: start_time,
    end_time: end_time,
    days: days
  )
end

puts "Created #{CourseClass.count} course classes"
