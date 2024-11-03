Feature: Add courses to database from Excel file

  Scenario: Admin uploads a valid file as ActiveStorage::Blob
    Given An Excel file has been uploaded as an ActiveStorage::Blob
    When The system processes the file with add_courses_to_database
    Then The courses should be added to the database
