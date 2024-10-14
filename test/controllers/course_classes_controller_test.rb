require "test_helper"

class CourseClassesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get course_classes_index_url
    assert_response :success
  end

  test "should get show" do
    get course_classes_show_url
    assert_response :success
  end

  test "should get new" do
    get course_classes_new_url
    assert_response :success
  end

  test "should get create" do
    get course_classes_create_url
    assert_response :success
  end

  test "should get edit" do
    get course_classes_edit_url
    assert_response :success
  end

  test "should get update" do
    get course_classes_update_url
    assert_response :success
  end

  test "should get destroy" do
    get course_classes_destroy_url
    assert_response :success
  end
end
