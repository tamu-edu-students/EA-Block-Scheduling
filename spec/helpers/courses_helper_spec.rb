require 'rails_helper'

RSpec.describe CoursesHelper, type: :helper do
  describe '#validate_courses' do
    context 'when course exists' do
      it 'does not set a flash error' do
        allow(Course).to receive(:exists?).with(as_id: 1).and_return(true)

        validate_courses(1)

        expect(flash[:error]).to be_nil
      end
    end

    context 'when course does not exist' do
      it 'sets a flash error' do
        allow(Course).to receive(:exists?).with(as_id: 99).and_return(false)

        validate_courses(99)

        expect(flash[:error]).to eq("Courses not found: 99")
      end
    end
  end
end
