Feature: Manage Courses
  As an administrator
  I want to manage courses
  So that I can maintain the course catalog

  Scenario: View course listing
    Given I am logged in as a test user
    And there is a course "Calculus I" in the system
    When I visit the courses page
    Then I should see course title "Calculus I"

  Scenario: Create a new course
    Given I am logged in as a test user
    And I visit the courses page
    And I click course button "New Course"
    And I fill in course field "Term" with "224F000"
    And I fill in course field "Dept code" with "PHYS"
    And I fill in course field "Sec name" with "PHYS-2425-001"
    And I fill in course field "Short title" with "Physics I"
    And I fill in course field "Days" with "MW"
    And I fill in course field "Start time" with "9:00 AM"
    And I fill in course field "End time" with "10:20 AM"
    And I click course button "Create Course"
    Then I should see course message "Physics I was successfully created"
    And I should see course title "Physics I"

  Scenario: Delete a course
    Given I am logged in as a test user
    And I visit the courses page
    And there is a course "Calculus I" in the system
    When I visit the courses page
    And I click course button "Delete" for section "MATH-2413-008"
    Then I should not see course title "Calculus I" with section "MATH-2413-008"