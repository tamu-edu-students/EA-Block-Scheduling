require 'rails_helper'

RSpec.describe CoursesHelper, type: :helper do
  describe '#validate_courses' do
    it 'validates course existence' do
      # Stub Course.exists? to return false
      allow(Course).to receive(:exists?).and_return(false)

      # Call the helper method
      helper.validate_courses("999")
    end
  end
end
