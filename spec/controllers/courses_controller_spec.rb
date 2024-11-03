require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
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
end
