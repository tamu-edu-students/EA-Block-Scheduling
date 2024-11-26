Feature: Create Courses with Prerequisites, Corequisites, and Category
  As an administrator
  I want to manage course prerequisites, corequisites, and category
  So that I can generate schedules

  Background:
    Given the following prerequisites exist:
      | course_code   | prerequisite_courses               |
      | MATH-2413     | MATH-2412                          |
      | ENGR-217      | ENGR-216, PHYS-2425, MATH-2414     |
      | PHYS-2426     | MATH-2414, PHYS-2425               |
    And the following corequisites exist:
      | course_code   | corequisite_courses       |
      | ENGR-102      | MATH-2412, MATH-2413      |
      | ENGR-216      | PHYS-2425                 |
    And the following categories exist:
      | prefix        | category       |
      | MATH          | Math           |
      | PHYS          | Science        |
      | ENGR          | Engineering    |
    And I am logged in as a test user
    And I visit the courses page

  Scenario: Create a course with prerequisites, corequisites, and category
    When I click course button "New Course"
    And I fill in course field "Term" with "224F000"
    And I fill in course field "Dept code" with "ENGR"
    And I fill in course field "Sec name" with "ENGR-217-001"
    And I fill in course field "Short title" with "Engineering I"
    And I fill in course field "Days" with "MW"
    And I fill in course field "Start time" with "9:00 AM"
    And I fill in course field "End time" with "10:20 AM"
    And I click course button "Create Course"
    Then I should see "Engineering I was successfully created."
    And the course "ENGR-217-001" should have prerequisites "ENGR-216, PHYS-2425, MATH-2414"
    And the course "ENGR-217-001" should have corequisites "PHYS-2426"
    And the course "ENGR-217-001" should be in category "Engineering"

  Scenario: Create a course with no prerequisites or corequisites
    When I click course button "New Course"
    And I fill in course field "Term" with "224F000"
    And I fill in course field "Dept code" with "MATH"
    And I fill in course field "Sec name" with "MATH-2412-001"
    And I fill in course field "Short title" with "Precalculus"
    And I fill in course field "Days" with "MW"
    And I fill in course field "Start time" with "9:00 AM"
    And I fill in course field "End time" with "10:20 AM"
    And I click course button "Create Course"
    Then I should see "Precalculus was successfully created."
    And the course "MATH-2412-001" should have no prerequisites
    And the course "MATH-2412-001" should have no corequisites
    And the course "MATH-2412-001" should be in category "Math"
