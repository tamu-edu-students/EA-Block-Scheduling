Feature: Excel Parser
  As an admin
  I want to upload an Excel file
  So that the file is parsed and data is stored in the database

  Background:
    Given an Excel file named "valid_excel_file_Spring_2025.xlsx" with valid course data

  Scenario: Parsing an Excel file and storing data in the database
    Given I upload the excel file "valid_excel_file_Spring_2025.xlsx"
    When The file is processed by the Excel parser
    Then I should see the parsed data stored in the database
    And The count of courses in the database should have increased