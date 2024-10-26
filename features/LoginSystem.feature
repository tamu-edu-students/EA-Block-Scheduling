Feature: Main page navigation and form submissions

  Scenario: Navigate to login page when Login button is clicked
    Given I am on the main page
    When I click the "Login" button for authentication
    Then I should be redirected to the login page

  Scenario: Navigate to sign-up page when Sign Up button is clicked
    Given I am on the main page
    When I click the "Sign Up" button for authentication
    Then I should be redirected to the sign-up page