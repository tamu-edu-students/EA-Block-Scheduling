require "test_helper"

class ExcelFilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @excel_file = excel_files(:one)
  end

  test "should get index" do
    get excel_files_url
    assert_response :success
  end

  test "should get new" do
    get new_excel_file_url
    assert_response :success
  end

  test "should create excel_file" do
    assert_difference("ExcelFile.count") do
      post excel_files_url, params: { excel_file: { name: @excel_file.name } }
    end

    assert_redirected_to excel_file_url(ExcelFile.last)
  end

  test "should show excel_file" do
    get excel_file_url(@excel_file)
    assert_response :success
  end

  test "should get edit" do
    get edit_excel_file_url(@excel_file)
    assert_response :success
  end

  test "should update excel_file" do
    patch excel_file_url(@excel_file), params: { excel_file: { name: @excel_file.name } }
    assert_redirected_to excel_file_url(@excel_file)
  end

  test "should destroy excel_file" do
    assert_difference("ExcelFile.count", -1) do
      delete excel_file_url(@excel_file)
    end

    assert_redirected_to excel_files_url
  end
end
