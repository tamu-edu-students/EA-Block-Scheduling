Feature: Excel File Upload
  As a user
  I want to upload Excel files
  So that I can store and process them later

  Scenario: Successfully attaching an Excel file
    Given I am on the new excel file page
    When I fill in "Name" with "Test Excel File"
    And I attach the file "test.xlsx" to "File"

  Scenario: Reject invalid file type
    Given I am on the new excel file page
    When I fill in "Name" with "Invalid File"
    And I attach the file "test.txt" to "File"
    And I click "Create Excel file" on excel page
    Then I should see "Filemust be an Excel file"

  Scenario: Redirect to view courses after upload is parsed
    Given I am on the show excel file page
    When I click the excel file link
    Then I should see the table of added courses
    And I should see "19" classes in a table
