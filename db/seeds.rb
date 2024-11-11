# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "\nClearing existing courses..."
Course.destroy_all

puts "\nStarting to seed courses..."

# Course prerequisites
prerequisites = {
  'MATH-2413' => ['MATH-2412'],
  'MATH-2414' => ['MATH-2413'],
  'MATH-2415' => ['MATH-2414'],
  'MATH-2420' => ['MATH-2415'],
  'ENGR-216' => %w[ENGR-102 MATH-2413],
  'ENGR-217' => %w[ENGR-216 PHYS-2425 MATH-2414],
  'CHEM-1312' => ['CHEM-1309'],
  'CHEM-1112' => ['CHEM-1309'],
  'PHYS-2425' => ['MATH-2413'],
  'PHYS-2426' => ['PHYS-2425']
}

corequisites = {
  'ENGR 102' => %w[MATH-2412 MATH-2413],
  'ENGR 216' => ['PHYS 2425'],
  'ENGR 217' => ['PHYS 2426']
}

puts "Prerequisites defined: #{prerequisites.keys.join(', ')}"

# All courses
courses = [
    { term: '224F000', dept_code: 'CHEM', course_id: '517302', sec_coreq_secs: '517302', syn: '93061', sec_name: 'CHEM-1309-001', short_title: 'Gen Chem Engr Lc', im: 1, building: 'HLC1', room: '2101', days: 'MW', start_time: '9:00 AM', end_time: '10:20 AM', fac_id: '', faculty_name: '', crs_capacity: 36, sec_cap: 0, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'CHEM', course_id: '517302', sec_coreq_secs: '517519', syn: '92850', sec_name: 'CHEM-1109-005', short_title: 'Gen Chem Engr Lb', im: 2, building: 'HLC1', room: '2109.00', days: 'M', start_time: ' 10:30 AM', end_time: ' 1:20 PM', fac_id: '', faculty_name: '', crs_capacity: 18, sec_cap: 0, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'CHEM', course_id: '517301', sec_coreq_secs: '517519', syn: '66857', sec_name: 'CHEM-1109-006', short_title: 'Gen Chem Engr Lb', im: 2, building: 'HLC1', room: '2109.00', days: 'W', start_time: ' 10:30 AM', end_time: ' 1:20 PM', fac_id: '', faculty_name: '', crs_capacity: 18, sec_cap: 0, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'CHEM', course_id: '517515', sec_coreq_secs: '517306', syn: '93058', sec_name: 'CHEM-1309-002', short_title: 'Gen Chem Engr Lc', im: 1, building: 'HLC1', room: '2102', days: 'TTh', start_time: ' 11:00 AM', end_time: ' 12:20 PM', fac_id: '', faculty_name: '', crs_capacity: 36, sec_cap: 0, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'CHEM', course_id: '517306', sec_coreq_secs: '517515', syn: '92854', sec_name: 'CHEM-1109-001', short_title: 'Gen Chem Engr Lb', im: 2, building: 'HLC1', room: '2109.00', days: 'T', start_time: ' 8:00 AM', end_time: ' 10:50 AM', fac_id: '', faculty_name: '', crs_capacity: 18, sec_cap: 0, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'CHEM', course_id: '517304', sec_coreq_secs: '517515', syn: '92852', sec_name: 'CHEM-1109-003', short_title: 'Gen Chem Engr Lb', im: 2, building: 'HLC1', room: '2109.00', days: 'Th', start_time: ' 8:00 AM', end_time: ' 10:50 AM', fac_id: '', faculty_name: '', crs_capacity: 18, sec_cap: 0, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'CHEM', course_id: '517503', sec_coreq_secs: '517305', syn: '93047', sec_name: 'CHEM-1309-003', short_title: 'Gen Chem Engr Lc', im: 1, building: 'HLC1', room: '2101', days: 'MW', start_time: ' 12:30 PM', end_time: ' 1:50 PM', fac_id: '', faculty_name: '', crs_capacity: 36, sec_cap: 18, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'CHEM', course_id: '517305', sec_coreq_secs: '517503', syn: '92853', sec_name: 'CHEM-1109-002', short_title: 'Gen Chem Engr Lb', im: 2, building: 'HLC1', room: '2109.00', days: 'M', start_time: ' 2:00 PM', end_time: ' 4:50 PM', fac_id: '', faculty_name: '', crs_capacity: 18, sec_cap: 9, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'CHEM', course_id: '517503', sec_coreq_secs: '517515', syn: '92851', sec_name: 'CHEM-1109-004', short_title: 'Gen Chem Engr Lb', im: 2, building: 'HLC1', room: '2109.00', days: 'W', start_time: ' 2:00 PM', end_time: ' 4:50 PM', fac_id: '', faculty_name: '', crs_capacity: 18, sec_cap: 9, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'CHEM', course_id: '', sec_coreq_secs: '', syn: '94822', sec_name: 'CHEM-1312-006', short_title: 'Gen Chem Engr Lc', im: 0, building: 'HLC1', room: '', days: 'TTh', start_time: '2:00 PM', end_time: '3:20 PM', fac_id: '', faculty_name: '', crs_capacity: 36, sec_cap: 18, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'CHEM', course_id: '', sec_coreq_secs: '', syn: '92982', sec_name: 'CHEM 1112-008', short_title: 'Gen Chem Engr Lb', im: 0, building: 'HLC1', room: '', days: 'T', start_time: '11:00 AM', end_time: '1:50 PM', fac_id: '', faculty_name: '', crs_capacity: 18, sec_cap: 9, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'CHEM', course_id: '', sec_coreq_secs: '', syn: '96793', sec_name: 'CHEM 1112-005', short_title: 'Gen Chem Engr Lb', im: 0, building: 'HLC1', room: '', days: 'Th', start_time: '11:00 AM', end_time: '1:50 PM', fac_id: '', faculty_name: '', crs_capacity: 18, sec_cap: 9, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'CHEM', course_id: '', sec_coreq_secs: '', syn: '99460', sec_name: 'CHEM-1309-007', short_title: 'Gen Chem Engr Lc', im: 0, building: 'HLC1', room: '', days: 'TTh', start_time: '5:00 PM', end_time: '6:20 PM', fac_id: '', faculty_name: '', crs_capacity: 36, sec_cap: 18, student_count: 0, notes: 'previously CHEM1311/1312 8 wk', as_id: 0 },

    { term: '224F000', dept_code: 'CHEM', course_id: '', sec_coreq_secs: '', syn: '99458', sec_name: 'CHEM 1109-011', short_title: 'Gen Chem Engr Lb', im: 0, building: 'HLC1', room: '', days: 'T', start_time: '2:00 PM', end_time: '4:50 PM', fac_id: '', faculty_name: '', crs_capacity: 18, sec_cap: 9, student_count: 0, notes: 'previously CHEM1311/1312 8 wk', as_id: 0 },

    { term: '224F000', dept_code: 'CHEM', course_id: '', sec_coreq_secs: '', syn: '99459', sec_name: 'CHEM 1109-012', short_title: 'Gen Chem Engr Lb', im: 0, building: 'HLC1', room: '', days: 'Th', start_time: '2:00 PM', end_time: '4:50 PM', fac_id: '', faculty_name: '', crs_capacity: 18, sec_cap: 9, student_count: 0, notes: 'previously CHEM1311/1312 8 wk', as_id: 0 },

    { term: '224F000', dept_code: 'MATH', course_id: '515994', sec_coreq_secs: '*', syn: '91557', sec_name: 'MATH-2412-018', short_title: 'PreCalculus', im: 1, building: 'HLC1', room: '2218', days: 'TTh', start_time: ' 4:00 PM', end_time: ' 5:45 PM', fac_id: '', faculty_name: '', crs_capacity: 36, sec_cap: 0, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'MATH', course_id: '', sec_coreq_secs: '', syn: '91560', sec_name: 'MATH-2412-029', short_title: 'PreCalculus', im: 0, building: 'HLC1', room: '', days: 'TTh', start_time: '1:30 PM', end_time: '3:15 PM', fac_id: '', faculty_name: '', crs_capacity: 36, sec_cap: 0, student_count: 0, notes: 'previously not EA section', as_id: 0 },

    { term: '224F000', dept_code: 'MATH', course_id: '', sec_coreq_secs: '', syn: '99445', sec_name: 'MATH-2412-017', short_title: 'PreCalculus', im: 0, building: 'HLC1', room: '', days: 'MW', start_time: '4:30 PM', end_time: '6:15 PM', fac_id: '', faculty_name: '', crs_capacity: 36, sec_cap: 0, student_count: 0, notes: 'previously MATH-2413-017', as_id: 0 },

    { term: '224F000', dept_code: 'MATH', course_id: '516003', sec_coreq_secs: '*', syn: '91566', sec_name: 'MATH-2413-008', short_title: 'Calculus I', im: 1, building: 'HLC1', room: '2216', days: 'MW', start_time: ' 8:35 AM', end_time: ' 10:20 AM', fac_id: '', faculty_name: '', crs_capacity: 36, sec_cap: 0, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'MATH', course_id: '516005', sec_coreq_secs: '*', syn: '91568', sec_name: 'MATH-2413-011', short_title: 'Calculus I', im: 1, building: 'HLC1', room: '2216', days: 'TTh', start_time: ' 10:55 AM', end_time: ' 12:40 PM', fac_id: '', faculty_name: '', crs_capacity: 36, sec_cap: 0, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'MATH', course_id: '493689', sec_coreq_secs: '', syn: '96975', sec_name: 'MATH-2413-004', short_title: 'Calculus I', im: 1, building: 'HLC1', room: '2105', days: 'TTh', start_time: ' 9:00 AM', end_time: ' 10:45 AM', fac_id: '', faculty_name: '', crs_capacity: 36, sec_cap: 18, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'MATH', course_id: '516015', sec_coreq_secs: '*', syn: '91578', sec_name: 'MATH-2414-002', short_title: 'Calculus II', im: 1, building: 'HLC2', room: '2222', days: 'TTh', start_time: ' 12:50 PM', end_time: ' 2:35 PM', fac_id: '', faculty_name: '', crs_capacity: 36, sec_cap: 18, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'MATH', course_id: '516017', sec_coreq_secs: '*', syn: '91580', sec_name: 'MATH-2414-004', short_title: 'Calculus II', im: 1, building: 'HLC1', room: '2209', days: 'TTh', start_time: ' 9:00 AM', end_time: ' 10:45 AM', fac_id: '', faculty_name: '', crs_capacity: 36, sec_cap: 18, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'MATH', course_id: '516026', sec_coreq_secs: '*', syn: '91589', sec_name: 'MATH-2415-003', short_title: 'Calculus III', im: 1, building: 'HLC1', room: '2216', days: 'MW', start_time: ' 6:00 PM', end_time: ' 7:45 PM', fac_id: '', faculty_name: '', crs_capacity: 36, sec_cap: 24, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'MATH', course_id: '516027', sec_coreq_secs: '*', syn: '91590', sec_name: 'MATH-2415-004', short_title: 'Calculus III', im: 1, building: 'HLC1', room: '2202', days: 'MW', start_time: ' 8:10 AM', end_time: ' 9:55 AM', fac_id: '', faculty_name: '', crs_capacity: 36, sec_cap: 24, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'MATH', course_id: '516030', sec_coreq_secs: '*', syn: '91593', sec_name: 'MATH-2420-001', short_title: 'Diff Equations', im: 1, building: 'HLC1', room: '2209', days: 'MW', start_time: ' 10:05 AM', end_time: ' 11:50 AM', fac_id: '', faculty_name: '', crs_capacity: 36, sec_cap: 24, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'PHYS', course_id: '516415', sec_coreq_secs: '*', syn: '91978', sec_name: 'PHYS-2425-013', short_title: 'Eng Phy I', im: 1, building: 'HLC1', room: '2202', days: 'MW', start_time: '12:00 PM', end_time: '2:50 PM', fac_id: '', faculty_name: '', crs_capacity: 24, sec_cap: 14, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'PHYS', course_id: '516416', sec_coreq_secs: '*', syn: '91979', sec_name: 'PHYS-2425-014', short_title: 'Eng Phy I', im: 1, building: 'HLC1', room: '2104', days: 'MW', start_time: '3:00 PM', end_time: '5:50 PM', fac_id: '', faculty_name: '', crs_capacity: 24, sec_cap: 14, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'PHYS', course_id: '521548', sec_coreq_secs: '*', syn: '97030', sec_name: 'PHYS-2426-009', short_title: 'Eng Phy II', im: 1, building: 'HLC1', room: '2403', days: 'TTh', start_time: '12:00 PM', end_time: '3:00 PM', fac_id: '', faculty_name: '', crs_capacity: 24, sec_cap: 14, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'PHYS', course_id: '494193', sec_coreq_secs: '', syn: '97025', sec_name: 'PHYS-2426-005', short_title: 'Eng Phy II', im: 1, building: 'HLC1', room: '1307', days: 'MW', start_time: '1:30 PM', end_time: '4:20 PM', fac_id: '', faculty_name: '', crs_capacity: 24, sec_cap: 14, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'ENGR', course_id: '102', sec_coreq_secs: '', syn: '', sec_name: 'ENGR-102-559', short_title: '', im: nil, building: 'HLC4', room: '1130.02', days: 'MW', start_time: '10:30 AM', end_time: '12:20 PM', fac_id: '', faculty_name: 'Shana Shaw', crs_capacity: 100, sec_cap: 100, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'ENGR', course_id: '102', sec_coreq_secs: '', syn: '', sec_name: 'ENGR-102-535', short_title: '', im: nil, building: 'HLC4', room: '1130.02', days: 'MW', start_time: '1:30 PM', end_time: '3:20 PM', fac_id: '', faculty_name: 'Shana Shaw', crs_capacity: 100, sec_cap: 100, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'CLEN', course_id: '181', sec_coreq_secs: '', syn: '', sec_name: 'CLEN-181-1', short_title: '', im: nil, building: 'HLC4', room: '1130.02', days: 'M', start_time: '12:30 PM', end_time: '1:20 PM', fac_id: '', faculty_name: 'Shana Shaw', crs_capacity: 25, sec_cap: 25, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'CLEN', course_id: '181', sec_coreq_secs: '', syn: '', sec_name: 'CLEN-181-2', short_title: '', im: nil, building: 'HLC4', room: '1130.02', days: 'T', start_time: '12:00 PM', end_time: '12:50 PM', fac_id: '', faculty_name: 'Shana Shaw', crs_capacity: 25, sec_cap: 25, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'CLEN', course_id: '181', sec_coreq_secs: '', syn: '', sec_name: 'CLEN-181-3', short_title: '', im: nil, building: 'HLC4', room: '1130.02', days: 'T', start_time: '1:00 PM', end_time: '1:50 PM', fac_id: '', faculty_name: 'Larry O\'Pella', crs_capacity: 25, sec_cap: 25, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'CLEN', course_id: '181', sec_coreq_secs: '', syn: '', sec_name: 'CLEN-181-4', short_title: '', im: nil, building: 'HLC4', room: '1130.02', days: 'T', start_time: '2:00 PM', end_time: '2:50 PM', fac_id: '', faculty_name: 'Larry O\'Pella', crs_capacity: 25, sec_cap: 25, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'CLEN', course_id: '181', sec_coreq_secs: '', syn: '', sec_name: 'CLEN-181-5', short_title: '', im: nil, building: 'ONLINE', room: '', days: 'W', start_time: '12:30 PM', end_time: '1:20 PM', fac_id: '', faculty_name: 'TBD', crs_capacity: 25, sec_cap: 25, student_count: 0, notes: 'new section', as_id: 0 },

    { term: '224F000', dept_code: 'CLEN', course_id: '181', sec_coreq_secs: '', syn: '', sec_name: 'CLEN-181-6', short_title: '', im: nil, building: 'ONLINE', room: '', days: 'Th', start_time: '12:00 PM', end_time: '12:50 PM', fac_id: '', faculty_name: 'TBD', crs_capacity: 25, sec_cap: 25, student_count: 0, notes: 'new section', as_id: 0 },

    { term: '224F000', dept_code: 'CLEN', course_id: '181', sec_coreq_secs: '', syn: '', sec_name: 'CLEN-181-7', short_title: '', im: nil, building: 'ONLINE', room: '', days: 'Th', start_time: '1:00 PM', end_time: '1:50 PM', fac_id: '', faculty_name: 'TBD', crs_capacity: 25, sec_cap: 25, student_count: 0, notes: 'new section', as_id: 0 },

    { term: '224F000', dept_code: 'ENGR', course_id: '216', sec_coreq_secs: '', syn: '', sec_name: 'ENGR-216-560', short_title: '', im: nil, building: 'HLC4', room: '1130.02', days: 'T', start_time: '11:00 AM', end_time: '5:50 PM', fac_id: '', faculty_name: 'Shana Shaw', crs_capacity: 24, sec_cap: 24, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'ENGR', course_id: '217', sec_coreq_secs: '', syn: '', sec_name: 'ENGR-217-575', short_title: '', im: nil, building: 'HLC4', room: '1130.02', days: 'WTh', start_time: '12:30 PM', end_time: '1:50 PM', fac_id: '', faculty_name: 'Shana Shaw', crs_capacity: 24, sec_cap: 24, student_count: 0, notes: '', as_id: 0 },

    { term: '224F000', dept_code: 'ENGR', course_id: '217', sec_coreq_secs: '', syn: '', sec_name: 'ENGR-217-576', short_title: '', im: nil, building: 'HLC4', room: '1130.02', days: 'WTh', start_time: '12:30 PM', end_time: '5:50 PM', fac_id: '', faculty_name: 'Shana Shaw', crs_capacity: 24, sec_cap: 24, student_count: 0, notes: '', as_id: 0 }
]

puts "Found #{courses.length} courses to create"

def extract_base_code(sec_name)
  standardized = sec_name.gsub(' ', '-')
  parts = standardized.split('-')
  "#{parts[0]}-#{parts[1]}"
end

# Create courses with prerequisites
courses.each do |course_data|
  base_code = extract_base_code(course_data[:sec_name])
  prereq_string = if prerequisites.key?(base_code)
    prerequisites[base_code].map(&:strip).join(', ')
  else
    nil
  end

  Course.create!(course_data.merge(prerequisites: prereq_string))
end

puts "\nSeeding completed!"
puts "Total courses created: #{Course.count}"
