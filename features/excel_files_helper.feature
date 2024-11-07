Feature: Add courses to database from Excel file

  Scenario: Admin uploads a valid file as ActiveStorage::Blob
    Given I am logged in as a test user
    When An Excel file has been uploaded as an ActiveStorage::Blob
    And The system processes the file with add_courses_to_database
    Then The courses should be added to the database
