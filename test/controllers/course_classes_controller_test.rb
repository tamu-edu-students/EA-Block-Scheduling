require "test_helper"

class CourseClassesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course_class = course_classes(:one)
  end

  test "should get index" do
    get course_classes_url
    assert_response :success
  end

  test "should get new" do
    get new_course_class_url
    assert_response :success
  end

  test "should create course_class" do
    assert_difference("CourseClass.count") do
      post course_classes_url, params: { course_class: { name: "New Course Class" } }
    end

    assert_redirected_to course_class_url(CourseClass.last)
  end

  test "should show course_class" do
    get course_class_url(@course_class)
    assert_response :success
  end

  test "should get edit" do
    get edit_course_class_url(@course_class)
    assert_response :success
  end

  test "should update course_class" do
    patch course_class_url(@course_class), params: { course_class: { name: "Updated Course Class" } }
    assert_redirected_to course_class_url(@course_class)
  end

  test "should destroy course_class" do
    assert_difference("CourseClass.count", -1) do
      delete course_class_url(@course_class)
    end

    assert_redirected_to course_classes_url
  end
end
