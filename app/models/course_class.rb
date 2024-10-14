class CourseClass < ApplicationRecord
  has_and_belongs_to_many :blocks

  def initialize(attributes = {})
    super
    self.days = attributes[:days].split(',') if attributes[:days].is_a?(String)
  end

  def formatted_time_range
    "#{start_time.strftime('%I:%M %p')} - #{end_time.strftime('%I:%M %p')}"
  end

  def formatted_days
    days.join(', ')
  end
end
