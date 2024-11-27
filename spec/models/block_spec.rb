require 'rails_helper'

RSpec.describe Block, type: :model do
  describe "validations" do
    let(:science_course) { create(:course, sec_name: 'PHYS 101-001', category: 'Science') }
    let(:math_course) { create(:course, sec_name: 'MATH 101-001', category: 'Math') }
    let(:engineering_course) { create(:course, sec_name: 'ENGR 101-001', category: 'Engineering') }
    let(:other_course) { create(:course, sec_name: 'CLEN 101-001', category: 'Other') }

    it "requires exactly 4 courses" do
      block = Block.new([science_course, math_course, engineering_course])
      expect(block).not_to be_valid
      expect(block.errors[:courses]).to include("must have exactly 4 courses")
    end

    it "requires one course from each required category" do
      block = Block.new([science_course, other_course, other_course, other_course])
      expect(block).not_to be_valid
      expect(block.errors[:base]).to include("Block must include at least one Math course")
      expect(block.errors[:base]).to include("Block must include at least one Engineering course")
    end

    it "validates no time conflicts" do
      course1 = create(:course, sec_name: 'MATH 102-001', category: 'Math',
                       days: "MW", start_time: "9:00 AM", end_time: "10:00 AM")
      course2 = create(:course, sec_name: 'PHYS 102-001', category: 'Science',
                       days: "MW", start_time: "9:30 AM", end_time: "10:30 AM")
      course3 = create(:course, sec_name: 'ENGR 102-001', category: 'Engineering',
                       days: "TTH", start_time: "9:00 AM", end_time: "10:00 AM")
      course4 = create(:course, sec_name: 'CLEN 102-001', category: 'Other',
                       days: "TTH", start_time: "10:30 AM", end_time: "11:30 AM")

      block = Block.new([course1, course2, course3, course4])
      expect(block).not_to be_valid
      expect(block.errors[:base]).to include(/Time conflict between/)
    end

    it "validates no duplicate course numbers" do
      course1 = create(:course, sec_name: "MATH 101-001", category: 'Math')
      course2 = create(:course, sec_name: "MATH 101-002", category: 'Math')
      course3 = create(:course, sec_name: "PHYS 101-001", category: 'Science')
      course4 = create(:course, sec_name: "ENGR 101-001", category: 'Engineering')
      block = Block.new([course1, course2, course3, course4])
      expect(block).not_to be_valid
      expect(block.errors[:base]).to include("Cannot have multiple sections of the same course")
    end

    it "validates no prerequisites in block" do
      prereq_course = create(:course, sec_name: "MATH 101-001", category: 'Math')
      dependent_course = create(:course, sec_name: "MATH 102-001", category: 'Math',
                                prerequisites: "MATH-101")
      science_course = create(:course, sec_name: "PHYS 101-001", category: 'Science')
      engineering_course = create(:course, sec_name: "ENGR 101-001", category: 'Engineering')
      block = Block.new([prereq_course, dependent_course, science_course, engineering_course])
      expect(block).not_to be_valid
      expect(block.errors[:base]).to include(/Cannot include .* with its prerequisites/)
    end
  end
end
