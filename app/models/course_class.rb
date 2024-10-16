class CourseClass < ApplicationRecord
  validates :course, :start_time, :end_time, :days, presence: true

  # Remove the custom initialize method
  # Instead, use before_validation callback to parse times
  before_validation :parse_times

  private

  def parse_times
    self.start_time = Time.parse(start_time.to_s) if start_time.is_a?(String)
    self.end_time = Time.parse(end_time.to_s) if end_time.is_a?(String)
  end
end
