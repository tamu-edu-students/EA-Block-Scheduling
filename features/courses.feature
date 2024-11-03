Feature: Course manipulation
  As an admin
  I want to be able to see courses the file parser has placed in the database
  So that I can make changes to existing or add new courses for the generator

  Background:
    Given the following courses exist:
    | term    | sec_name | days | start_time | end_time | crs_capacity | sec_cap | student_count | as_id |
    | 224F000 | chem_101 | MW   | 1:30 PM    | 3:20 PM  | 24           | 12      | 0             | 1     |
    | 224F000 | phys_101 | MW   | 3:30 PM    | 5:20 PM  | 24           | 12      | 0             | 1     |
    | 224F000 | phys_102 | MW   | 5:30 PM    | 6:20 PM  | 12           |  6      | 0             | 1     |
    | 225S000 | chem_101 | MW   | 1:30 PM    | 3:20 PM  | 24           | 12      | 0             | 2     |
    | 225S000 | phys_101 | MW   | 3:30 PM    | 5:20 PM  | 24           | 12      | 0             | 2     |
    | 225S000 | phys_102 | MW   | 5:30 PM    | 6:20 PM  | 12           |  6      | 0             | 2     |

    Scenario: show courses by active storage id
      Given I am on the courses page to see courses with an active storage id of 1
      Then I should see "224F000" in the table
