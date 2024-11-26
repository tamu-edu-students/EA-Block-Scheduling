require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  let(:user) { User.create!(email: "test@example.com", first_name: "Test", last_name: "User", role: "admin", uid: "123456789", provider: "google_oauth2") }
  before do
    # Simulate logged-in user by setting session[:user_id]
    session[:user_id] = user.id
  end
  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns @courses and @prerequisites" do
      course = create(:course)
      get :index
      expect(assigns(:courses)).to eq([course])
      expect(assigns(:prerequisites)).to include(course.sec_name => ['MATH-2412'])
    end
  end

  describe "GET #show" do
    let(:course) { create(:course) }

    it "returns a successful response" do
      get :show, params: { id: course.id }
      expect(response).to be_successful
    end

    it "assigns @prerequisites correctly" do
      get :show, params: { id: course.id }
      expect(assigns(:prerequisites)).to eq(['MATH-2412'])
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      let(:valid_params) {
        { course: attributes_for(:course) }
      }

      it "creates a new course" do
        expect {
          post :create, params: valid_params
        }.to change(Course, :count).by(1)
      end

      it "redirects to courses path with success message" do
        post :create, params: valid_params
        expect(response).to redirect_to(courses_path)
        expect(flash[:notice]).to match(/successfully created/)
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) {
        { course: attributes_for(:course, sec_name: '', short_title: '') }
      }

      it "does not create a new course" do
        expect {
          post :create, params: invalid_params
        }.not_to change(Course, :count)
      end

      it "returns unprocessable entity status and renders new" do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "PATCH #update" do
    let(:course) { create(:course) }

    context "with valid parameters" do
      let(:new_attributes) {
        { short_title: 'Updated Title' }
      }

      it "updates the course" do
        patch :update, params: { id: course.id, course: new_attributes }
        course.reload
        expect(course.short_title).to eq('Updated Title')
      end

      it "redirects with success message" do
        patch :update, params: { id: course.id, course: new_attributes }
        expect(response).to redirect_to(course_path(course))
        expect(flash[:notice]).to match(/successfully updated/)
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) {
        { sec_name: '', short_title: '' }
      }

      it "returns unprocessable entity status and renders edit" do
        patch :update, params: { id: course.id, course: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:edit)
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:course) { create(:course) }

    it "destroys the course" do
      expect {
        delete :destroy, params: { id: course.id }
      }.to change(Course, :count).by(-1)
    end

    it "redirects with success message" do
      delete :destroy, params: { id: course.id }
      expect(response).to redirect_to(courses_path)
      expect(flash[:notice]).to match(/successfully deleted/)
    end
  end

  describe 'GET #show_by_upload' do
    let(:as_id) { 123 }
    let!(:course1) { Course.create!(as_id: as_id, short_title: 'Course 1', sec_name: 'Course 1') }
    let!(:course2) { Course.create!(as_id: as_id, short_title: 'Course 2', sec_name: 'Course 2') }
    let!(:course3) { Course.create!(as_id: 456, short_title: 'Course 3', sec_name: 'Course 3') }

    before do
      allow(controller).to receive(:validate_courses).with(as_id.to_s).and_return(true)
    end

    it 'validates the courses using the given as_id' do
      expect(controller).to receive(:validate_courses).with(as_id.to_s)
      get :show_by_upload, params: { as_id: as_id }
    end

    it 'assigns @courses with courses matching the as_id' do
      get :show_by_upload, params: { as_id: as_id }
      expect(assigns(:courses)).to match_array([course1, course2])
    end

    it 'does not include courses with a different as_id' do
      get :show_by_upload, params: { as_id: as_id }
      expect(assigns(:courses)).not_to include(course3)
    end
  end

  describe 'GET #new' do
    it 'assigns a new Course to @course' do
      get :new
      expect(assigns(:course)).to be_a_new(Course)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe '#get_prerequisite_names' do
    context 'when prerequisites are blank' do
      it 'returns "None"' do
        result = controller.get_prerequisite_names('')
        expect(result).to eq('None')
      end
    end

    context 'when prerequisites are nil' do
      it 'returns "None"' do
        result = controller.get_prerequisite_names(nil)
        expect(result).to eq('None')
      end
    end

    context 'when prerequisites are present' do
      it 'returns a formatted string with unique prerequisites' do
        prerequisites = 'Math 101, Physics 101, Math 101'
        result = controller.get_prerequisite_names(prerequisites)
        expect(result).to eq('Math 101, Physics 101')
      end

      it 'strips extra spaces around prerequisites' do
        prerequisites = 'Math 101, Physics 101'
        result = controller.get_prerequisite_names(prerequisites)
        expect(result).to eq('Math 101, Physics 101')
      end
    end
  end
end
