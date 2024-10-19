require "application_system_test_case"

class ExcelFilesTest < ApplicationSystemTestCase
  setup do
    @excel_file = excel_files(:one)
  end

  test "visiting the index" do
    visit excel_files_url
    assert_selector "h1", text: "Excel files"
  end

  test "should create excel file" do
    visit excel_files_url
    click_on "New excel file"

    fill_in "Name", with: @excel_file.name
    click_on "Create Excel file"

    assert_text "Excel file was successfully created"
    click_on "Back"
  end

  test "should update Excel file" do
    visit excel_file_url(@excel_file)
    click_on "Edit this excel file", match: :first

    fill_in "Name", with: @excel_file.name
    click_on "Update Excel file"

    assert_text "Excel file was successfully updated"
    click_on "Back"
  end

  test "should destroy Excel file" do
    visit excel_file_url(@excel_file)
    click_on "Destroy this excel file", match: :first

    assert_text "Excel file was successfully destroyed"
  end
end
