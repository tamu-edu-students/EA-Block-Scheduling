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
    And I select "Admin" as the role
    And I click the "Update" button
    Then I should be redirected to the "new_email@example.com" detail page
    And I should see the user with email "new_email@example.com"
    And I should see the user with first name "New First Name"
    And I should see the user with last name "New Last Name"
    And I should see the user with role "Admin"

  Scenario: Deleting a user
    When I delete the user "user@example.com"
    Then I should see "user@example.com was successfully deleted."
    And I should not see "user@example.com"