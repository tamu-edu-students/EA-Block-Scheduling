Feature: Destroy Excel File
  As an admin user
  I want to delete existing Excel files
  So that I can remove outdated or incorrect uploads

  Scenario: Attempting to delete a non-existent Excel file
    Given I am logged in as a test user
    When I attempt to delete an Excel file with ID "9999"
    Then I should see "Excel file not found."
