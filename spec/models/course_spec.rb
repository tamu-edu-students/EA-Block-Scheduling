require 'rails_helper'

RSpec.describe Course, type: :model do
  before(:all) do
    @course0 = if described_class.where(course_id: '517302', syn: '93061').empty?
      described_class.create(term: '224F000', dept_code: 'CHEM', course_id: '517302', sec_coreq_secs: '517302', syn: '93061', sec_name: 'CHEM-1309-001', short_title: 'Gen Chem Engr Lc', im: 1, building: 'HLC1', room: '2101', days: 'MW', start_time: '9:00 AM', end_time: '10:20 AM', fac_id: '', faculty_name: '', crs_capacity: 36, sec_cap: 0, student_count: 0, notes: '')
    else
      described_class.find_by(course_id: '517302', syn: '93061')
    end

    @course1 = if described_class.where(course_id: '517302', syn: '92850').empty?
      described_class.create(term: '224F000', dept_code: 'CHEM', course_id: '517302', sec_coreq_secs: '517519', syn: '92850', sec_name: 'CHEM-1109-005', short_title: 'Gen Chem Engr Lb', im: 2, building: 'HLC1', room: '2109.00', days: 'M', start_time: ' 10:30 AM', end_time: ' 1:20 PM', fac_id: '', faculty_name: '', crs_capacity: 18, sec_cap: 0, student_count: 0, notes: '')
    else
      described_class.find_by(course_id: '517302', syn: '92850')
    end

    @course2 = if described_class.where(course_id: '517302', syn: '66857').empty?
      described_class.create(term: '224F000', dept_code: 'CHEM', course_id: '517301', sec_coreq_secs: '517519', syn: '66857', sec_name: 'CHEM-1109-006', short_title: 'Gen Chem Engr Lb', im: 2, building: 'HLC1', room: '2109.00', days: 'W', start_time: ' 10:30 AM', end_time: ' 1:20 PM', fac_id: '', faculty_name: '', crs_capacity: 18, sec_cap: 0, student_count: 0, notes: '')
    else
      described_class.find_by(course_id: '517302', syn: '66857')
    end
  end

  describe 'Courses exist' do
    courses = Course.all
    it 'Fetches all courses' do
      expect(courses).to include(@course0, @course1, @course2)
    end
  end
end
