Feature: Generate Course Schedules

  Background:
    Given I am on the "Generate Schedule" page

  Scenario: Display list of selected courses
    When I visit the "Generate Schedule" page
    Then I should see the "Selected Courses" title
    And I should see a table with course codes, names, and instructors
    And I should see the following courses:
      | Course Code | Course Name                     | Instructor       |
      | CS101       | Introduction to Computer Science| Dr. Alice Smith  |
      | CS202       | Data Structures                 | Dr. Mark Lee     |
      | CS301       | Operating Systems               | Prof. Emily Johnson |

  Scenario: Generate schedule
    Given I visit the "Generate Schedule" page
    Then I should see the "Generate Schedule" button
    When I click the "Generate Schedule" button
    Then I should see "2 schedules generated" in the schedule banner
    And I should see links "View Schedule 1" and "View Schedule 2"

