Feature: Excel File Upload
  As a user
  I want to upload Excel files
  So that I can store and process them later

  Scenario: Successfully attaching an Excel file
    Given I am logged in as a test user
    And I am on the new excel file page
    When I fill in "Name" with "Test Excel File"
    And I attach the file "test.xlsx" to "File"
    

  Scenario: Reject invalid file type
    Given I am logged in as a test user
    And I am on the new excel file page
    When I fill in "Name" with "Invalid File"
    And I attach the file "test.txt" to "File"
    And I click "Create Excel file" on excel page
    Then I should see "Filemust be an Excel file"