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
      Given I am logged in as a test user
      And I am on the courses page to see courses with an active storage id of 1
      Then I should see "224F000" in the table

    Scenario: Invalid course validation
      Then I should get an error for invalid course "INVALID-101"

    Scenario: Blank prerequisites handling
      Then I should get "None" for blank prerequisites

    Scenario: Course code extraction
      Then the base code for "MATH-2414-007" should be "MATH-2414"
      And the type for "MATH-2414-007" should be "MATH"

    Scenario: Course mappings verification
      Then I should see correct course mappings

    Scenario: Non-blank prerequisites handling
      Then I should get prerequisite list for "MATH-2413, PHYS-2425"

    Scenario: Course update
      Given the following courses exist:
        | term    | sec_name | days | start_time | end_time | short_title |
        | 224F000 | CHEM-101 | MW   | 1:30 PM    | 3:20 PM  | Chemistry   |
      When I update the course "CHEM-101" with:
        | term        | 224F001 |
        | short_title | Chem I  |
      Then I should see a success notice "Chem I was successfully updated."
