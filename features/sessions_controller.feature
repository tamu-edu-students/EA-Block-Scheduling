Feature: Sessions Controller

Scenario: User logs out successfully
  Given I am logged in as a student
  When I log out
  Then I should be redirected to the home page
  And I should see the notice "You are logged out."

  Scenario: Admin user logs in successfully
    Given OmniAuth is configured with valid credentials for an admin
    When I log in via Google
    Then I should be redirected to admin dashboard
    And I should see a link with the text "Admin Settings"

  Scenario: Student user logs in successfully
    Given OmniAuth is configured with valid credentials for a student
    When I log in via Google
    Then I should be redirected to the students dashboard
    And I should see a link with the text "My Schedule"

  Scenario: OmniAuth login fails
    Given OmniAuth is configured with invalid credentials
    When I try to log in via Google
    Then I should be redirected to the home page
    And I should see the notice "Please sign in to access services"
