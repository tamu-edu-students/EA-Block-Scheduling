Feature: User profile page

    Scenario: Viewing a user's profile page
        Given I am logged in as a test user
        When I visit the user's profile page
        Then I should see the user's details