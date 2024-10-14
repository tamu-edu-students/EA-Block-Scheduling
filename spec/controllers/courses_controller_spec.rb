require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  before(:all) do
    Course.destroy_all

    @course0 = Course.create(term: '224F000', dept_code: 'CHEM', course_id: '517302', sec_coreq_secs: '517302', syn: '93061', sec_name: 'CHEM-1309-001', short_title: 'Gen Chem Engr Lc', im: 1, building: 'HLC1', room: '2101', days: 'MW', start_time: '9:00 AM', end_time: '10:20 AM', fac_id: '', faculty_name: '', crs_capacity: 36, sec_cap: 0, student_count: 0, notes: '')
    @course1 = Course.create(term: '224F000', dept_code: 'CHEM', course_id: '517302', sec_coreq_secs: '517519', syn: '92850', sec_name: 'CHEM-1109-005', short_title: 'Gen Chem Engr Lb', im: 2, building: 'HLC1', room: '2109.00', days: 'M', start_time: ' 10:30 AM', end_time: ' 1:20 PM', fac_id: '', faculty_name: '', crs_capacity: 18, sec_cap: 0, student_count: 0, notes: '')
    @course2 = Course.create(term: '224F000', dept_code: 'CHEM', course_id: '517301', sec_coreq_secs: '517519', syn: '66857', sec_name: 'CHEM-1109-006', short_title: 'Gen Chem Engr Lb', im: 2, building: 'HLC1', room: '2109.00', days: 'W', start_time: ' 10:30 AM', end_time: ' 1:20 PM', fac_id: '', faculty_name: '', crs_capacity: 18, sec_cap: 0, student_count: 0, notes: '')
  end

  describe 'Create course' do
    it 'course with valid parameters' do
      get :create, params: { course: { term: '224F000',
                                       dept_code: 'TEST',
                                       course_id: '123456',
                                       sec_coreq_secs: '123456',
                                       syn: '98765',
                                       sec_name: 'TEST-1301-001',
                                       short_title: 'Gen Test Course',
                                       im: 1,
                                       building: 'HLC1',
                                       room: '2000',
                                       days: 'MWF',
                                       start_time: '9:00 AM',
                                       end_time: '10:20 AM',
                                       fac_id: '',
                                       faculty_name: '',
                                       crs_capacity: 36,
                                       sec_cap: 0,
                                       student_count: 0,
                                       notes: '' } }
      expect(response).to redirect_to courses_path
      expect(flash[:notice]).to match(/Gen Test Course was successfully created./)
    end
  end

  describe 'Updates course' do
    it 'redirects to the course details page and flashes a notice' do
      get :update, params: {
        id: @course0.id,
        course: {
          dept_code: 'TEST'
        }
      }
      expect(response).to redirect_to course_path(@course0)
      expect(flash[:notice]).to match(/Gen Chem Engr Lc was successfully updated./)
      @course0.destroy
    end

    it 'actually updated the course' do
      course = Course.create(term: '224F000', dept_code: 'ENG', course_id: '123456', sec_coreq_secs: '123456', syn: '98765', sec_name: 'TEST-1300-000', short_title: 'Gen Test Test Course', im: 1, building: 'TEST1', room: '1', days: 'M', start_time: ' 10:30 AM', end_time: ' 1:20 PM', fac_id: '', faculty_name: '', crs_capacity: 18, sec_cap: 0, student_count: 0, notes: '')
      get :update, params: {
        id: course.id,
        course: {
          dept_code: 'TEST'
        }
      }
      expect(assigns(:course).dept_code).to eq('TEST')
      course.destroy
    end
  end

  describe 'Destroy course' do
    it 'destroys the course' do
      @course0.destroy
      courses = Course.all
      expect(courses).to include(@course1, @course2)
    end
  end
end
