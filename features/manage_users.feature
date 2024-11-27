@manage_users
Feature: Manage Users
  As an admin
  I want to manage users
  So that I can view, update, and delete user accounts

  Background:
    Given the following users exist:
      | email             | first_name | last_name | uid  | provider      |
      | admin@example.com | Admin      | User      | 123  | google_oauth2 |
      | user@example.com  | Test       | User      | 456  | google_oauth2 |
      | test@example.com  | Tester     | Userer    | 789  | google_oauth2 |
    And there is an admin user with email "admin@adminuser.com"
    And I log in with Google as "admin@adminuser.com"

  Scenario: Viewing the list of users
    When I visit the users index page
    Then I should see the following users:
      | Email              |
      | admin@example.com  |
      | user@example.com   |
      | test@example.com   |

  Scenario: Viewing a user's profile
    When I visit the profile page for "user@example.com"
    Then I should see "Test"

  Scenario: Update a user
    Given I am on the edit user page for the user "user@example.com"
    When I fill in the email field with "new_email@example.com"
    And I fill in the first name field with "New First Name"
    And I fill in the last name field with "New Last Name"
    And I check the "Student" role checkbox
    And I click the "Update" button
    Then I should be redirected to the "new_email@example.com" detail page
    And I should see the user with email "new_email@example.com"
    And I should see the user with first name "New First Name"
    And I should see the user with last name "New Last Name"
    And I should see the user with role "Student"

  Scenario: Deleting a user
    When I delete the user "user@example.com"
    Then I should see "user@example.com was successfully deleted."
    And I should not see "user@example.com"

  Scenario: Add a Role to a User
    Given a user exists without the "admin" role
    When I navigate to the edit user page
    And I check the "admin" role checkbox
    And I click the "Update" button
    Then the user should have the "admin" role

  Scenario: Remove a Role from a User
    Given a user exists with the "admin" role
    When I navigate to the edit user page
    And I uncheck the "admin" role checkbox
    And I click the "Update" button
    Then the user should not have the "admin" role

  Scenario: Add Multiple Roles to a User
    Given a user exists without the "admin" and "moderator" roles
    When I navigate to the edit user page
    And I check the "admin" and "moderator" role checkboxes
    And I click the "Update" button
    Then the user should have the "admin" and "moderator" roles

  Scenario: Remove Multiple Roles from a User
    Given a user exists with the "admin" and "moderator" roles
    When I navigate to the edit user page
    And I uncheck the "admin" and "moderator" role checkboxes
    And I click the "Update" button
    Then the user should not have the "admin" and "moderator" roles